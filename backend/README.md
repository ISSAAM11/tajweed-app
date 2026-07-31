# Tajweed AI — Backend

Django + Django REST Framework + Channels backend. Implements the **Recitation
Test** feature (spec: `docs/specs/recitation-test/`): a WebSocket that proxies
live audio to Deepgram streaming STT and returns per-word recitation verdicts.

## Setup

```powershell
# From this directory
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
copy .env.example .env   # then set DEEPGRAM_API_KEY
```

## Run

```powershell
venv\Scripts\activate
python manage.py migrate
python manage.py runserver        # serves HTTP + WebSocket via Daphne (ASGI)
```

`runserver` uses Daphne (listed first in `INSTALLED_APPS`), so WebSockets work in
dev. For production, run the ASGI app directly: `daphne config.asgi:application`.

## Endpoints

| Protocol | URL                 | Description                          |
| -------- | ------------------- | ------------------------------------ |
| GET      | `/api/health/`      | Health-check                         |
| WS       | `/ws/recitation/`   | Live recitation session (see below)  |
| —        | `/admin/`           | Django admin                         |

### WebSocket contract (`/ws/recitation/`)

```jsonc
// App → Django (first message)
{ "type": "config", "expected_words": ["بسم", "الله", "الرحمن", "..."] }
// App → Django: then raw binary PCM audio frames (linear16, 16 kHz, mono)
// App → Django: { "type": "stop" }   to finalize the session

// Django → App
{ "type": "verdict", "word_index": 3, "is_correct": true, "final": false } // tentative
{ "type": "verdict", "word_index": 3, "is_correct": true, "final": true  } // locked
{ "type": "done" }
{ "type": "error", "reason": "deepgram_unavailable" }
```

## Settings

Split per environment; select with `DJANGO_SETTINGS_MODULE`
(default `config.settings.development`):

- `config/settings/base.py` — shared config
- `config/settings/development.py` — `DEBUG=True`, permissive CORS
- `config/settings/production.py` — secrets/hosts from env, explicit CORS allow-list

## Project layout

```
config/                 settings (split), root URLconf, WSGI + ASGI(+Channels) entrypoints
apps/
├── core/               shared app — health endpoint
└── recitation/         the Recitation Test feature
    ├── consumers.py    Channels WebSocket consumer (transport only)
    ├── routing.py      ws/recitation/ route
    ├── services/       pure, unit-tested logic (no I/O):
    │   ├── normalization.py   letters-only Arabic normalization
    │   ├── alignment.py       online pointer + look-ahead aligner
    │   └── deepgram_client.py async Deepgram streaming wrapper
    └── tests/          normalization, alignment, consumer (happy + error paths)
manage.py
```

## Tests

```powershell
python manage.py test
```
