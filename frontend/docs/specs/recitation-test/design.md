# Design — Recitation Test (Feature 1.6)

## 1. Topology

The Deepgram API key stays server-side; the app never talks to Deepgram directly. Django
proxies audio to Deepgram and runs the alignment.

```
 Flutter mic ──(audio bytes, ws)──►  Django Channels  ──(audio bytes, ws)──► Deepgram STT
                                          │   ◄──(transcript words, ws)──────────┘
                                          │   online letter-alignment vs expected words
        Flutter UI  ◄──(per-word verdicts, ws)──┘
```

- One Flutter ⇄ Django WebSocket per recitation session.
- Django holds a second WebSocket out to Deepgram for that same session.
- Alignment + letter-matching run **server-side** (one source of truth).

---

## 2. End-to-end data flow

```
[Flutter] capture mic (PCM chunks)
   └─► [Flutter] send `config` then stream raw audio frames over ws
        └─► [Django] relay audio bytes to Deepgram
             └─► [Deepgram] stream back recognized words (interim + final)
                  └─► [Django] normalize (letters only) both sides
                       └─► [Django] online align recognized vs expected (pointer + look-ahead)
                            └─► [Django] emit per-word verdict over ws
                                 └─► [Flutter] BLoC updates verdict map → word chip recolors
```

---

## 3. WebSocket message contract

**App → Django (first message, JSON):**
```jsonc
{ "type": "config", "surah": 1, "expected_words": ["بسم", "الله", "الرحمن", ...] }
```
Sending `expected_words` keeps Django stateless regarding Quran data. (Alternative: Django
loads them from its own copy by `surah`.)

**App → Django (then, repeatedly):** raw binary audio frames.

**Django → App (verdict messages, JSON):**
```jsonc
{ "type": "verdict", "word_index": 3, "is_correct": true,  "final": false } // interim → tentative color
{ "type": "verdict", "word_index": 3, "is_correct": true,  "final": true  } // committed → lock green/red
{ "type": "done" }                                                          // session ended
{ "type": "error", "reason": "deepgram_unavailable" }                       // failure
```
- `word_index` indexes the expected word list the app already displays.
- `final=false` → tentative; `final=true` → locked verdict.

---

## 4. Normalization (letters only)

Applied to **both** the expected Quran words and the Deepgram-recognized words before any
comparison, so the two sides are on equal footing:

- strip all tashkeel / diacritics
- unify alef forms (`أ إ آ ا` → `ا`)
- remove tatweel elongation (`ـ`)
- unify taa marbuta / haa (`ة` → `ه`)

Result: each word becomes a bare letter sequence; equality is a plain string compare.

---

## 5. Online alignment algorithm

Because recognized words arrive as a **growing prefix**, Django cannot run a one-shot global
diff. It keeps a **moving pointer** and a small look-ahead window:

- Maintain `pointer` = next expected word not yet committed.
- For each incoming recognized word (normalized):
  - equals `expected[pointer]` → mark **correct**, advance pointer.
  - equals a word within look-ahead (`pointer+1 .. pointer+k`) → the skipped words in between
    are marked **incorrect**, then advance past the match.
  - matches nothing in the window → mark `expected[pointer]` **incorrect** and advance
    (treat as misrecited; configurable).
- **Commit rule:** only emit `final=true` when Deepgram marks the word `is_final`. Interim
  words emit `final=false` so the UI previews without committing.

**Contrast with batch:** the batch approach has the full recognized text and does a global
optimal alignment. Streaming trades that for an **online pointer + look-ahead +
commit-on-final**. The normalization and the equality test itself are identical to batch.

---

## 6. Frontend (Flutter) module

Standard feature-module layout under `lib/src/features/home/quran/recitation_test/`:

```
recitation_test/
├── binding/      RecitationTestDeps          (DI registration)
├── data/
│   ├── models/   WordVerdictModel            (word_index, is_correct, final)
│   └── datasource/  RecitationSocketClient   (WebSocket wrapper)
├── router/       recitation_test_route.dart  (/recitation-test)
├── view/
│   ├── screen/   recitation_test_screen.dart (extends Feature<Bloc, State>)
│   └── widgets/  recitation_word_chip.dart   (neutral / tentative / green / red)
└── vm/
    ├── bloc/     RecitationTestBloc
    ├── events/   LoadWords, StartSession, AudioChunkReady, VerdictReceived, StopSession, Reset
    ├── states/   Idle, Listening, Error
    └── usecases/ recitation_test_uc.dart     (extension on the bloc)
```

### 6a. Audio capture
- `record` package in **stream mode** (`startStream`) → raw PCM chunks.
- Configured `linear16`, 16 kHz, mono to match the Deepgram input declared by Django.
- Each chunk is pushed straight onto the WebSocket sink.

### 6b. WebSocket client
- `web_socket_channel`.
- On start: open the socket to Django, send the `config` message, then stream audio bytes.
- Listen for `verdict` / `done` / `error` messages → dispatch BLoC events.

### 6c. State machine
- `Idle(words)` — surah loaded, all neutral.
- `Listening(words, verdicts)` — socket open, mic streaming; `verdicts` maps
  `word_index → (is_correct, final)` and drives chip colors.
- `Error(message)` — socket/mic failure; allow retry.

### 6d. BLoC dependencies
- `QuranPageDao` — `getWordsForSurah(1)` to load Al-Fatiha from the local prebuilt DB.
- `RecitationSocketClient` — the WebSocket wrapper.
- A recorder controller from `record` — held as a field; `onDispose` must stop the stream and
  close the socket.

---

## 7. Backend (Django) responsibilities

- **Transport:** Django **Channels** (ASGI) WebSocket consumer, e.g. `ws/recitation/`.
- **On connect:** read the surah / expected words; open a streaming socket to Deepgram with
  `language=ar`, `interim_results=true`, and audio params matching the app
  (`encoding=linear16`, `sample_rate=16000`, mono); init alignment pointer.
- **On audio chunk:** relay bytes to Deepgram.
- **On Deepgram transcript:** extract words (text, `is_final`, confidence) → normalize →
  online-align → emit verdicts to the app.
- **On disconnect / stop:** close the Deepgram socket, flush final verdicts, tear down.
- **Service layer:** normalization + alignment live in a plain module (no HTTP/WS concerns)
  so they are unit-testable in isolation.
- **Sync handling:** Al-Fatiha is short → handle within the live socket session; introduce
  Celery only when longer surahs are added.

---

## 8. Package & config additions (frontend)

| Where | Addition |
|-------|----------|
| `pubspec.yaml` | `record` (mic streaming) + `web_socket_channel` |
| `lib/src/app/environment/environments.dart` | `wsBaseUrl` per environment (Django socket) |
| `lib/src/database/daos/quran_page_dao.dart` | `getWordsForSurah(int surah)` ordered word list |
| `android/app/src/main/AndroidManifest.xml` | `<uses-permission android:name="android.permission.RECORD_AUDIO"/>` |

---

## 9. Design-system & i18n compliance (CLAUDE.md)

- Colors via `AppColors.*`: green = `AppColors.primary`, red = `AppColors.error`, tentative =
  a muted tint, neutral = grey. No hardcoded colors.
- Word font via `AppFonts` Uthmani style; sizes via `FontSizes.*`; spacing via `AppMetrics.*`.
  Any custom sizing goes in `components.dart`, not inline.
- All user-facing strings via `AppLocalizations`; keys added to **both** `app_en.arb` and
  `app_ar.arb` in the same edit.
- AppBar wrapped in `Directionality(textDirection: TextDirection.ltr, ...)`; the body lets
  the locale drive direction (Arabic RTL).

---

## 10. Pre-build spike (do first)

Before building the socket stack, validate the risky assumption: feed **real Quranic
recitation audio** to Deepgram (`language=ar`, streaming) and check whether recognized words
are accurate enough that letter-matching yields sensible greens/reds. Quranic classical
Arabic differs from Deepgram's conversational training data. If accuracy is poor, revisit
model/params (or strategy) before investing in the full WebSocket build.
