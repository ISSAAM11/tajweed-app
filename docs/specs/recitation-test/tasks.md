# Tasks — Recitation Test (Feature 1.6)

> Ordered so the backend WebSocket contract is fixed before the frontend wires to it.
> Mirrors the task checkboxes in [IMPLEMENTATION-TRACKER.md](../../IMPLEMENTATION-TRACKER.md) → Feature 1.6.

---

## Phase 0 — Pre-build spike

- [ ] Feed real Quranic recitation audio to Deepgram (`language=ar`, streaming) and assess
      Arabic word accuracy. Decide go / no-go on streaming before building the stack.

---

## Phase 1 — Backend (Django)

- [ ] Add Django **Channels** (ASGI) to the backend; configure routing for `ws/recitation/`.
- [ ] WebSocket consumer: accept the `config` message, open a Deepgram streaming socket
      (`language=ar`, `interim_results=true`, `encoding=linear16`, `sample_rate=16000`, mono).
- [ ] Audio relay: forward incoming binary frames from the app to Deepgram.
- [ ] **Normalization util** (letters only): strip tashkeel, unify alef forms, remove tatweel,
      unify taa marbuta/haa. Pure function, unit-tested.
- [ ] **Online alignment service**: moving pointer + look-ahead window; commit on `is_final`.
      Pure logic, unit-tested with crafted recognized/expected sequences.
- [ ] Verdict serialization: emit `verdict` (`word_index`, `is_correct`, `final`), `done`,
      and `error` messages per the contract in `design.md`.
- [ ] Teardown: close Deepgram socket and clean up session state on disconnect/stop.
- [ ] Backend tests (normalization, alignment, consumer happy-path + error-path).

---

## Phase 2 — Frontend (Flutter)

- [ ] `pubspec.yaml`: add `record` and `web_socket_channel`; `flutter pub get`.
- [ ] `android/app/src/main/AndroidManifest.xml`: add `RECORD_AUDIO` permission.
- [ ] `lib/src/app/environment/environments.dart`: add `wsBaseUrl` per environment.
- [ ] `lib/src/database/daos/quran_page_dao.dart`: add `getWordsForSurah(int surah)` (ordered
      by ayah then word).
- [ ] Feature module skeleton under `lib/src/features/home/quran/recitation_test/`
      (binding / data / router / view / vm), following the project's feature pattern.
- [ ] `RecitationSocketClient` (data/datasource): open socket, send `config`, stream audio
      bytes, expose an inbound message stream.
- [ ] `WordVerdictModel` (data/models): `word_index`, `is_correct`, `final`.
- [ ] BLoC + events + states + usecases:
      - events: `LoadWords`, `StartSession`, `AudioChunkReady`, `VerdictReceived`,
        `StopSession`, `Reset`.
      - states: `Idle`, `Listening(words, verdicts)`, `Error`.
      - usecases: load words from DAO; start recorder stream + open socket; pump audio chunks;
        apply verdicts to the map; stop/reset; dispose cleanup (stop stream + close socket).
- [ ] `recitation_test_screen.dart` (extends `Feature<RecitationTestBloc, RecitationTestState>`):
      AppBar (LTR-locked), RTL body, `Wrap` of word chips, state-aware mic/stop/retry button.
- [ ] `recitation_word_chip.dart`: neutral / tentative / green / red, Uthmani font, tokens only.
- [ ] `recitation_test_route.dart`: define `/recitation-test`; register in
      `lib/src/app/router/app_router.dart`.
- [ ] `RecitationTestDeps` binding: register `RecitationSocketClient` + `RecitationTestBloc`
      (inject `QuranPageDao` via `get()`).
- [ ] **Home wiring**: in `lib/src/features/home/screen/widgets/home_screen.dart`, change the
      4th `HomeAction` (currently `homeQuranReflection` / `homeStartReflection`, lightbulb,
      no route) to the new feature — set `targetRoute: '/recitation-test'` and an appropriate
      icon (e.g. `Icons.record_voice_over_rounded`).
- [ ] **ARB re-text** (both files): repurpose `homeQuranReflection` → "Recitation Test" /
      "اختبار التلاوة" and `homeStartReflection` → "Start recitation" / "ابدأ التلاوة"
      (or add new keys `homeRecitationTest` / `homeStartRecitationTest` and switch the action
      to them — keep `app_en.arb` and `app_ar.arb` in lockstep).
- [ ] i18n keys for the screen itself (title, start, stop, listening, try again, mic-denied
      error, generic error) in **both** ARB files; `flutter pub get` to regenerate.
- [ ] Widget tests: word list renders neutral; verdict map drives colors; reset clears colors.

---

## Phase 3 — Verification

- [ ] `flutter analyze` — zero new issues.
- [ ] With a local/echo socket: open `/recitation-test`, confirm words render, audio streams,
      verdicts recolor words (tentative → locked), reset works.
- [ ] Toggle Arabic in `/settings` — text flips, AppBar stays LTR.
- [ ] End-to-end with the real Django + Deepgram backend once available.
