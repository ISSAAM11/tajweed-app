"""Phase 0 spike (design.md §10): assess Deepgram Arabic accuracy on Quranic audio.

Decodes an audio file to linear16 / 16 kHz / mono with ffmpeg, streams it to
Deepgram (language=ar) through the same DeepgramStream wrapper the consumer uses,
and prints the recognized words (raw + normalized). Use the output to make the
go / no-go call on streaming before trusting the green/red verdicts.

Usage:
    python scripts/deepgram_spike.py "path/to/recitation.mp3"
"""

import asyncio
import os
import subprocess
import sys
from pathlib import Path

# Arabic output needs UTF-8 even on a cp1252 Windows console.
sys.stdout.reconfigure(encoding="utf-8")

# Make the project importable and load settings/.env.
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.development")

import django  # noqa: E402

django.setup()

from django.conf import settings  # noqa: E402

from apps.recitation.services.deepgram_client import DeepgramStream  # noqa: E402
from apps.recitation.services.normalization import normalize_word  # noqa: E402

SAMPLE_RATE = 16000
CHUNK_MS = 100
BYTES_PER_CHUNK = SAMPLE_RATE * 2 * CHUNK_MS // 1000  # 16-bit mono


def decode_to_pcm(audio_path: str) -> bytes:
    """ffmpeg -> raw linear16 16 kHz mono PCM bytes."""
    result = subprocess.run(
        [
            "ffmpeg", "-i", audio_path,
            "-f", "s16le", "-acodec", "pcm_s16le",
            "-ar", str(SAMPLE_RATE), "-ac", "1",
            "-loglevel", "error", "pipe:1",
        ],
        stdout=subprocess.PIPE,
        check=True,
    )
    return result.stdout


async def run(audio_path: str) -> None:
    pcm = decode_to_pcm(audio_path)
    print(f"audio: {audio_path}")
    print(f"decoded: {len(pcm)} bytes (~{len(pcm) / (SAMPLE_RATE * 2):.1f}s)\n")

    stream = await DeepgramStream.connect(api_key=settings.DEEPGRAM_API_KEY)

    final_words: list[str] = []

    async def reader() -> None:
        async for transcript in stream.transcripts():
            tag = "FINAL" if transcript.is_final else "interim"
            if transcript.words:
                print(f"[{tag}] {' '.join(transcript.words)}")
            if transcript.is_final:
                final_words.extend(transcript.words)

    reader_task = asyncio.create_task(reader())

    # Stream in ~realtime so Deepgram segments naturally.
    for offset in range(0, len(pcm), BYTES_PER_CHUNK):
        await stream.send_audio(pcm[offset : offset + BYTES_PER_CHUNK])
        await asyncio.sleep(CHUNK_MS / 1000)

    await stream.finish()
    await asyncio.sleep(2)  # let trailing finals arrive
    reader_task.cancel()
    await stream.close()

    print("\n=== recognized (final) words ===")
    print("raw:        ", " ".join(final_words) or "(none)")
    print("normalized: ", " ".join(normalize_word(w) for w in final_words) or "(none)")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit("usage: python scripts/deepgram_spike.py <audio-file>")
    asyncio.run(run(sys.argv[1]))
