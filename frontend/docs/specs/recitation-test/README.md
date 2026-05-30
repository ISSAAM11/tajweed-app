# Spec: Recitation Test (Feature 1.6)

> Real-time AI recitation validation. The user recites a short surah aloud; each word
> lights up **green** (correct) or **red** (wrong/skipped) live as they recite.

**Status:** `Spec` — not yet implemented.
**Module:** Home · **Feature:** 1.6 · **Tracker:** [IMPLEMENTATION-TRACKER.md](../../IMPLEMENTATION-TRACKER.md) → Feature 1.6

---

## What this is

A new **Recitation Test** screen that helps the user read and spell Quran words correctly.
The app captures the microphone, streams the audio over a WebSocket to a Django backend,
which proxies it to **Deepgram streaming STT**, compares the recognized words
**letter-by-letter** against the expected Quran words, and pushes a per-word verdict back to
the app in real time. The frontend colors each displayed word accordingly.

The screen is launched from the **4th Home action** (currently "Quran reflection"), which is
repurposed to "Recitation Test" and wired to the `/recitation-test` route.

## Scope of v1

- **One static surah** — Al-Fatiha only. No surah selection.
- **Letters-only matching** — diacritics (tashkeel) are stripped before comparison; no
  strict vowel/tajweed scoring.
- **Simple true/false per word** — the focus is the AI pipeline architecture, validated on a
  short surah, not fine-grained tajweed accuracy.

## Documents

| File | Purpose |
|------|---------|
| [`requirements.md`](./requirements.md) | The WHAT & WHY — user stories (INVEST) + acceptance criteria (EARS) + scope |
| [`design.md`](./design.md) | The HOW — topology, data flow, WebSocket contract, alignment algorithm, module structure |
| [`tasks.md`](./tasks.md) | Implementation breakdown — backend (Django) + frontend (Flutter), ordered |

## Related project docs

- [`CLAUDE.md`](../../../CLAUDE.md) — codebase contract (architecture, hard rules).
- [`DESIGN_SYSTEM.md`](../../../DESIGN_SYSTEM.md) — UI tokens (read before any UI work).
- [`docs/VIBECODING-GUIDE.md`](../../VIBECODING-GUIDE.md) — the spec-driven methodology.
- [`docs/commercial/LISTE-DES-FONCTIONS.md`](../../commercial/LISTE-DES-FONCTIONS.md) — product spec (Feature 1.6).
