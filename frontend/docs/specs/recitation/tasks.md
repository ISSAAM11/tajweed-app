# Tasks — Quran-Page Recitation (Feature 1.7)

> Frontend-only: the backend WebSocket pipeline is reused unchanged from Feature 1.6.
> Mirrors [IMPLEMENTATION-TRACKER.md](../../IMPLEMENTATION-TRACKER.md) → Feature 1.7.
> `[x]` = implemented in the current branch; `[ ]` = remaining.

---

## Phase 1 — Frontend (Flutter)

- [x] Page-scoped recitation Bloc under `page/vm/recitation/` — single rich state
      (`modeActive`, `recording`, `hideText`, `pageNo`, `wordIndexById`, `verdicts`,
      `errorKey`) with `verdictForWordId` + `isComplete`.
- [x] Events: `EnterRecitationMode`, `ExitRecitationMode`, `ToggleHideText`,
      `StartPageRecitation`, `StartRecitation` (kept popup flow), `RestartRecitation`,
      `StopRecording`, `RecitationPageChanged`, internal `AudioChunkReady` / `VerdictReceived`
      / `RecitationFailed`.
- [x] Shared `_beginSession` (mic permission → open socket → `sendConfig` → stream) reusing the
      `record` pcm16/16k/mono config and `RecitationSocketClient`.
- [x] Auto-stop when `isComplete` (every expected word final) inside `onVerdictReceived`.
- [x] `recitation_words.dart`: `recitableWordsFromPage(page, {fromSurah, fromAyah})` +
      `maxSurahOnPage(page)`.
- [x] `RecitationBottomBar` (bottom app bar): start toggle / control row (record, hide-text,
      restart, next-surah, exit) styled with `AppMetrics.audioBar`.
- [x] `tajweed_text.dart`: verdict glyph coloring + hide-text reveal-on-verdict.
- [x] `quran_page_screen.dart`: provide `QuranRecitationBloc`, bottom app bar, error snackbar
      (errorKey), and `QuranPageBloc.currentPage` → `notifyPageChanged` bridge.
- [x] `page_viewer.dart`: floating button to start from the selected verse; keep the per-verse
      popup mic (`StartRecitation`).
- [x] DI: register `QuranRecitationBloc` in `QuranPageDependencies` (own `RecitationSocketClient`
      instance to avoid clashing with the recitation_test feature).
- [x] i18n keys in **both** ARB files (`recitationModeTooltip`, `recitationExit`,
      `recitationHideText`, `recitationShowText`, `recitationRestart`, `recitationNextSurah`);
      `flutter gen-l10n`.

---

## Phase 2 — Verification

- [x] `flutter analyze` on the page feature — zero new issues.
- [ ] With the Django + Deepgram backend on the LAN (`runserver 0.0.0.0:8000`, `wsBaseUrl` set):
      enter mode, record, recite the page → words recolor live; finishing the page auto-stops.
- [ ] Hide-text: words hidden, reveal in green/red as recited.
- [ ] Restart resets to the first word of the page; next jumps to the next surah and resets.
- [ ] FAB starts from the selected verse; popup mic still recites verse → end of surah.
- [ ] Toggle Arabic in `/settings` — bar/labels flip; Quran swipe stays RTL.
