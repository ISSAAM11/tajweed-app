"""Loopback smoke test for the recitation WebSocket.

Connects to the local consumer, sends a `config` message, then a `stop`, and
prints whatever the server sends back. Confirms WS routing + the consumer logs
end to end (without needing the Flutter app or a microphone).

Usage (from backend/, server already running):
    python scripts/ws_smoke_test.py
"""

import asyncio
import json

import websockets

URL = "ws://127.0.0.1:8000/ws/recitation/"


async def main() -> None:
    print(f"connecting -> {URL}")
    async with websockets.connect(URL) as ws:
        print("connected; sending config")
        await ws.send(json.dumps({"type": "config", "expected_words": ["بسم", "الله"]}))
        # Give the server a moment to open Deepgram (or report an error).
        await asyncio.sleep(2)
        await ws.send(json.dumps({"type": "stop"}))
        try:
            while True:
                msg = await asyncio.wait_for(ws.recv(), timeout=4)
                print("<- ", msg)
        except asyncio.TimeoutError:
            print("(no more messages)")
        except websockets.ConnectionClosed:
            print("(socket closed by server)")


if __name__ == "__main__":
    asyncio.run(main())
