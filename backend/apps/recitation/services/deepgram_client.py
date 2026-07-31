"""Thin async wrapper around Deepgram's streaming STT WebSocket.

Django holds one of these per recitation session (design.md §1): it forwards raw
PCM audio frames up to Deepgram and yields recognized words back. Kept free of
Channels concerns so the consumer can mock it in tests.
"""

import json
import urllib.parse
from collections.abc import AsyncIterator
from dataclasses import dataclass

import websockets

_DEEPGRAM_WS_URL = "wss://api.deepgram.com/v1/listen"


@dataclass(frozen=True)
class Transcript:
    """One Deepgram result: the recognized words and whether it is committed."""

    words: list[str]
    is_final: bool


class DeepgramStream:
    """An open streaming connection to Deepgram for a single session."""

    def __init__(self, connection: "websockets.WebSocketClientProtocol") -> None:
        self._ws = connection

    @classmethod
    async def connect(
        cls,
        *,
        api_key: str,
        language: str = "ar",
        sample_rate: int = 16000,
        encoding: str = "linear16",
        channels: int = 1,
        model: str = "nova-3",  # Arabic streaming requires nova-3
        interim_results: bool = True,
    ) -> "DeepgramStream":
        """Open the streaming socket with audio params matching the app's mic."""
        params = {
            "language": language,
            "model": model,
            "encoding": encoding,
            "sample_rate": str(sample_rate),
            "channels": str(channels),
            "interim_results": "true" if interim_results else "false",
            "punctuate": "false",  # keep words as bare tokens for letter-matching
        }
        url = f"{_DEEPGRAM_WS_URL}?{urllib.parse.urlencode(params)}"
        headers = {"Authorization": f"Token {api_key}"}

        # websockets renamed the header kwarg in v14 (extra_headers -> additional_headers).
        try:
            connection = await websockets.connect(url, additional_headers=headers)
        except TypeError:
            connection = await websockets.connect(url, extra_headers=headers)
        return cls(connection)

    async def send_audio(self, chunk: bytes) -> None:
        """Relay a raw PCM audio frame to Deepgram."""
        await self._ws.send(chunk)

    async def transcripts(self) -> AsyncIterator[Transcript]:
        """Yield recognized-word transcripts as Deepgram returns them."""
        async for raw in self._ws:
            print(f"[recitation] deepgram raw: {raw}")
            transcript = self._parse(raw)
            if transcript is not None:
                yield transcript

    @staticmethod
    def _parse(raw: str | bytes) -> Transcript | None:
        try:
            message = json.loads(raw)
        except (TypeError, ValueError):
            return None
        if message.get("type") not in (None, "Results"):
            return None  # ignore Metadata / SpeechStarted / UtteranceEnd frames
        alternatives = message.get("channel", {}).get("alternatives", [])
        if not alternatives:
            return None
        words = [word["word"] for word in alternatives[0].get("words", []) if "word" in word]
        return Transcript(words=words, is_final=bool(message.get("is_final")))

    async def finish(self) -> None:
        """Tell Deepgram no more audio is coming so it flushes final results."""
        try:
            await self._ws.send(json.dumps({"type": "CloseStream"}))
        except websockets.exceptions.WebSocketException:
            pass

    async def close(self) -> None:
        """Close the underlying socket."""
        await self._ws.close()
