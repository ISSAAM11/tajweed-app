from unittest import IsolatedAsyncioTestCase, mock

from channels.testing import WebsocketCommunicator
from django.test import override_settings

from apps.recitation.consumers import RecitationConsumer
from apps.recitation.services.deepgram_client import Transcript

WS_PATH = "/ws/recitation/"


class FakeDeepgram:
    """Stand-in for DeepgramStream: replays a scripted transcript sequence."""

    script: list[Transcript] = []

    def __init__(self) -> None:
        self.sent: list[bytes] = []
        self.closed = False

    @classmethod
    async def connect(cls, **kwargs) -> "FakeDeepgram":
        return cls()

    async def send_audio(self, chunk: bytes) -> None:
        self.sent.append(chunk)

    async def transcripts(self):
        for transcript in type(self).script:
            yield transcript

    async def finish(self) -> None:
        pass

    async def close(self) -> None:
        self.closed = True


def _communicator() -> WebsocketCommunicator:
    return WebsocketCommunicator(RecitationConsumer.as_asgi(), WS_PATH)


class RecitationConsumerTests(IsolatedAsyncioTestCase):
    async def test_happy_path_emits_verdicts(self):
        FakeDeepgram.script = [Transcript(words=["بسم", "الله"], is_final=True)]
        with override_settings(DEEPGRAM_API_KEY="test-key"), mock.patch(
            "apps.recitation.consumers.DeepgramStream", FakeDeepgram
        ):
            communicator = _communicator()
            connected, _ = await communicator.connect()
            self.assertTrue(connected)

            await communicator.send_json_to(
                {"type": "config", "expected_words": ["بسم", "الله"]}
            )

            first = await communicator.receive_json_from(timeout=2)
            second = await communicator.receive_json_from(timeout=2)
            self.assertEqual(first, {"type": "verdict", "word_index": 0, "is_correct": True, "final": True})
            self.assertEqual(second, {"type": "verdict", "word_index": 1, "is_correct": True, "final": True})

            await communicator.disconnect()

    async def test_missing_api_key_reports_deepgram_unavailable(self):
        with override_settings(DEEPGRAM_API_KEY=""):
            communicator = _communicator()
            await communicator.connect()
            await communicator.send_json_to(
                {"type": "config", "expected_words": ["بسم"]}
            )
            message = await communicator.receive_json_from(timeout=2)
            self.assertEqual(message["type"], "error")
            self.assertEqual(message["reason"], "deepgram_unavailable")
            await communicator.disconnect()

    async def test_empty_expected_words_reports_error(self):
        with override_settings(DEEPGRAM_API_KEY="test-key"):
            communicator = _communicator()
            await communicator.connect()
            await communicator.send_json_to({"type": "config", "expected_words": []})
            message = await communicator.receive_json_from(timeout=2)
            self.assertEqual(message["type"], "error")
            self.assertEqual(message["reason"], "no_expected_words")
            await communicator.disconnect()

    async def test_stop_flushes_remaining_and_signals_done(self):
        FakeDeepgram.script = []  # no transcripts; user stops before reciting
        with override_settings(DEEPGRAM_API_KEY="test-key"), mock.patch(
            "apps.recitation.consumers.DeepgramStream", FakeDeepgram
        ):
            communicator = _communicator()
            await communicator.connect()
            await communicator.send_json_to(
                {"type": "config", "expected_words": ["بسم", "الله"]}
            )
            await communicator.send_json_to({"type": "stop"})

            # Both unreached words are locked incorrect, then a done message.
            v0 = await communicator.receive_json_from(timeout=2)
            v1 = await communicator.receive_json_from(timeout=2)
            done = await communicator.receive_json_from(timeout=2)
            self.assertEqual(v0, {"type": "verdict", "word_index": 0, "is_correct": False, "final": True})
            self.assertEqual(v1, {"type": "verdict", "word_index": 1, "is_correct": False, "final": True})
            self.assertEqual(done, {"type": "done"})

            await communicator.disconnect()
