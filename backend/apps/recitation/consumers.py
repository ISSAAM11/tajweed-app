"""WebSocket consumer for a live recitation session (design.md §3, §7).

Transport only: it owns the Flutter⇄Django socket, drives a per-session
``DeepgramStream``, and delegates all judgement to ``OnlineAligner``. The message
contract (config in, verdict/done/error out) is defined in design.md §3.
"""

import asyncio
import json
import logging

from channels.generic.websocket import AsyncWebsocketConsumer
from django.conf import settings

from .services.alignment import OnlineAligner, Verdict
from .services.deepgram_client import DeepgramStream

logger = logging.getLogger(__name__)


class RecitationConsumer(AsyncWebsocketConsumer):
    """One instance per Flutter⇄Django recitation session."""

    async def connect(self) -> None:
        self._aligner: OnlineAligner | None = None
        self._deepgram: DeepgramStream | None = None
        self._reader: asyncio.Task | None = None
        self._audio_chunks = 0
        await self.accept()

    async def disconnect(self, code: int) -> None:
        await self._teardown()

    async def receive(self, text_data: str | None = None, bytes_data: bytes | None = None) -> None:
        if bytes_data is not None:
            await self._handle_audio(bytes_data)
        elif text_data is not None:
            await self._handle_control(text_data)

    # -- control messages (JSON) ------------------------------------------------

    async def _handle_control(self, text_data: str) -> None:
        try:
            message = json.loads(text_data)
        except json.JSONDecodeError:
            await self._send_error("bad_request")
            return

        message_type = message.get("type")
        if message_type == "config":
            await self._configure(message)
        elif message_type == "stop":
            await self._stop()
        else:
            await self._send_error("unknown_message")

    async def _configure(self, message: dict) -> None:
        if self._aligner is not None:
            return  # already configured; ignore duplicate config
        expected_words = message.get("expected_words") or []
        if not isinstance(expected_words, list) or not expected_words:
            await self._send_error("no_expected_words")
            return

        self._aligner = OnlineAligner(expected_words)

        api_key = getattr(settings, "DEEPGRAM_API_KEY", "")
        if not api_key:
            await self._send_error("deepgram_unavailable")
            return
        try:
            self._deepgram = await DeepgramStream.connect(api_key=api_key)
        except Exception:  # noqa: BLE001 — any connect failure is reported uniformly
            logger.exception("Failed to open Deepgram stream")
            await self._send_error("deepgram_unavailable")
            return

        self._reader = asyncio.create_task(self._read_deepgram())

    # -- audio frames -----------------------------------------------------------

    async def _handle_audio(self, chunk: bytes) -> None:
        if self._deepgram is None:
            return  # audio before config is dropped
        self._audio_chunks += 1
        if self._audio_chunks % 50 == 0 or self._audio_chunks == 1:
            peak = max(chunk) if chunk else 0  # ~0 = silence, up to 255 = real sound
            print(f"[recitation] received audio: {self._audio_chunks} chunks "
                  f"(last {len(chunk)} bytes, peak byte {peak})")
        try:
            await self._deepgram.send_audio(chunk)
        except Exception:  # noqa: BLE001
            logger.exception("Failed to relay audio to Deepgram")
            await self._send_error("deepgram_unavailable")
            await self._teardown()

    # -- Deepgram → alignment → verdicts ----------------------------------------

    async def _read_deepgram(self) -> None:
        assert self._deepgram is not None and self._aligner is not None
        try:
            async for transcript in self._deepgram.transcripts():
                if not transcript.words:
                    continue
                print("pong")
                tag = "final" if transcript.is_final else "interim"
                print(f"[recitation] deepgram ({tag}): {' '.join(transcript.words)}")
                if transcript.is_final:
                    verdicts = self._aligner.consume_final_words(transcript.words)
                else:
                    verdicts = self._aligner.preview_words(transcript.words)
                for verdict in verdicts:
                    await self._send_verdict(verdict)
        except asyncio.CancelledError:
            raise
        except Exception:  # noqa: BLE001
            logger.exception("Deepgram read loop failed")
            await self._send_error("deepgram_unavailable")

    async def _stop(self) -> None:
        """Finalize the session: drain Deepgram's finals, then flush + signal done."""
        # Tell Deepgram no more audio is coming; it replies with any pending final
        # results and then closes, which ends the reader loop. Drain it first so
        # those last words commit before we mark anything as unrecited.
        if self._deepgram is not None:
            await self._deepgram.finish()
        if self._reader is not None:
            try:
                await asyncio.wait_for(self._reader, timeout=5)
            except (asyncio.TimeoutError, asyncio.CancelledError, Exception):  # noqa: BLE001
                pass
            self._reader = None
        if self._aligner is not None:
            for verdict in self._aligner.flush_remaining():
                await self._send_verdict(verdict)
        await self._send_done()
        await self._teardown()

    # -- outbound messages ------------------------------------------------------

    async def _send_verdict(self, verdict: Verdict) -> None:
        await self.send(
            text_data=json.dumps(
                {
                    "type": "verdict",
                    "word_index": verdict.word_index,
                    "is_correct": verdict.is_correct,
                    "final": verdict.final,
                }
            )
        )

    async def _send_done(self) -> None:
        await self.send(text_data=json.dumps({"type": "done"}))

    async def _send_error(self, reason: str) -> None:
        await self.send(text_data=json.dumps({"type": "error", "reason": reason}))

    # -- teardown ---------------------------------------------------------------

    async def _teardown(self) -> None:
        if self._reader is not None:
            self._reader.cancel()
            try:
                await self._reader
            except (asyncio.CancelledError, Exception):  # noqa: BLE001
                pass
            self._reader = None
        if self._deepgram is not None:
            try:
                await self._deepgram.close()
            except Exception:  # noqa: BLE001
                pass
            self._deepgram = None
