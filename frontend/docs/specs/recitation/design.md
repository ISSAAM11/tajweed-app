# Design — Quran-Page Recitation (Feature 1.7)

## 1. Topology

Identical transport to Feature 1.6 — only the Flutter consumer of the verdicts changes.

```
 Flutter mic ──(audio bytes, ws)──►  Django Channels  ──(audio bytes, ws)──► Deepgram STT
                                          │   ◄──(transcript words, ws)──────────┘
                                          │   online letter-alignment vs expected words
   Quran page UI  ◄──(per-word verdicts, ws)──┘   (glyphs recolor in place)
```

The Django consumer, normalization, and online alignment are **reused unchanged** from
Feature 1.6. The WebSocket message contract (`config` / binary audio / `verdict` / `done` /
`error`) is exactly [recitation-test/design.md §3](../recitation-test/design.md).

---

## 2. Page-scoped data flow

```
[Quran page] user enters recitation mode (bottom app bar)
   └─► taps record → build expected words from the *rendered* page
        └─► expected = recitable words of QuranPageBloc.state.page (markers filtered)
             └─► open ws, send `config` (expected), stream mic frames
                  └─► verdicts arrive → map word_index → expected index → WordRow.id
                       └─► QuranLineText recolors that glyph (tentative → locked)
                            └─► all words final → auto-stop (mic off, coloring stays)
```

Source of truth for "what's on the page" is the already-built `PageContentDto` blocks
(`LineWordsBlockDto.lineWords`), so the recited set matches exactly what is drawn (respecting
page boundaries). Helper: `recitableWordsFromPage(page, {fromSurah, fromAyah})` in
`page/vm/recitation/recitation_words.dart`.

---

## 3. Index alignment (reused mechanism)

The backend reports `word_index` into the **filtered** expected list. The bloc builds, on each
start, `wordIndexById: Map<WordRow.id, expectedIndex>` plus the `expected` list. `QuranLineText`
looks up `state.verdictForWordId(word.id)` per rendered word. Because the map + verdicts cover
the whole started range, coloring survives page swipes.

---

## 4. Entry points & control bar

- **Bottom app bar** (`RecitationBottomBar`, set as `Scaffold.bottomNavigationBar`): off →
  a "start recitation" button (`enterMode`); on → the control row.
- **Control row:** record toggle (`startPage`/`stopRecording`), hide-text toggle
  (`toggleHideText`), restart (`startPage` with full page words), next-surah
  (`QuranPageBloc.initToVerse(VerseKey(maxSurahOnPage+1, 1))`), exit (`exitMode`), plus a
  listening/idle status.
- **Floating button** (in `PageViewer`, where the verse selection lives): when a verse is
  selected, starts a page session sliced from that verse (`recitableWordsFromPage(..., fromSurah,
  fromAyah)`).
- **Per-verse popup mic** (kept from Feature 1.6 wiring): `StartRecitation(surah, ayah)` —
  surah-scoped, cross-page.

---

## 5. Hide-text behavior

`QuranLineText` (tajweed_text.dart) watches the recitation state. When `modeActive && hideText`,
each word with no verdict yet is rendered hidden (transparent glyph over a neutral
placeholder block preserving width); once a verdict arrives the glyph is revealed in its
verdict color and stays. With hide-text off, the normal glyph is colored by the verdict. The
existing selected/playing highlight composes with this.

---

## 6. Completion / auto-stop detection

State exposes `isComplete` = every value of `wordIndexById` has a final verdict. In
`onVerdictReceived`, after merging a verdict, if `recording && isComplete` the bloc stops the
mic, sends `stop`, and sets `recording = false` (mode stays active so results remain visible).

---

## 7. Page-navigation coupling

`QuranPageScreen` hosts both blocs. A `BlocListener<QuranPageBloc>` (listenWhen on
`currentPage`) calls `recitation.notifyPageChanged(currentPage)` while in mode — tearing down
any recording and clearing the word map so the next start rebuilds from the new page. This
also handles the next-surah jump (which changes `currentPage`).

---

## 8. Frontend module map

```
quran/page/
├── vm/recitation/
│   ├── quran_recitation_bloc.dart      (Bloc — owned by BlocProvider; close() tears down)
│   ├── events/quran_recitation_events.dart
│   │     EnterRecitationMode, ExitRecitationMode, ToggleHideText,
│   │     StartPageRecitation(pageNo, words), StartRecitation(surah, ayah),
│   │     RestartRecitation, StopRecording, RecitationPageChanged,
│   │     AudioChunkReady, VerdictReceived, RecitationFailed
│   ├── states/quran_recitation_state.dart
│   │     single state: modeActive, recording, hideText, pageNo,
│   │     wordIndexById, verdicts, errorKey + verdictForWordId / isComplete
│   ├── usecases/quran_recitation_uc.dart   (handlers + shared _beginSession)
│   └── recitation_words.dart               (recitableWordsFromPage / maxSurahOnPage)
└── widgets/
    ├── recitation_bar.dart   (RecitationBottomBar — bottomNavigationBar)
    ├── tajweed_text.dart      (verdict coloring + hide-text rendering)
    ├── page_viewer.dart       (FAB start-from-position; kept popup mic)
    └── quran_page_screen.dart (providers, page bridge, error snackbar, bottom bar)
```

Reused from Feature 1.6: `RecitationSocketClient`, `WordVerdictModel` /
`RecitationServerMessage` (imported from `recitation_test/data/...`), the `record` config
(pcm16/16k/mono). DB: `QuranPageDao.getSurahWordsFromAyah(surah, ayah)` (null-safe raw select)
for the surah-scoped popup flow.

---

## 9. Design-system & i18n compliance (CLAUDE.md)

- Colors via `AppColors.*`: green = `AppColors.success`, red = `AppColors.error`, hidden
  placeholder = `greyLight` / `darkSurface`. Bar styling reuses `AppMetrics.audioBar`.
- All bar/tooltip strings via `AppLocalizations`, added to **both** ARB files:
  `recitationModeTooltip`, `recitationExit`, `recitationHideText`, `recitationShowText`,
  `recitationRestart`, `recitationNextSurah` (+ reused `recitationListening`,
  `recitationStart`, `recitationStop`, `recitationStartTooltip`, `recitation*` errors).
- The Quran page swipe stays RTL-locked; the bottom bar respects locale direction.
