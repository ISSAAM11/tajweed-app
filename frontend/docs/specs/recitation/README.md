# Spec: Quran-Page Recitation (Feature 1.7)

> A memorization-oriented recitation mode **inside the Quran reading page**. The user
> recites the visible page aloud; each word turns **green** (correct) or **red** (wrong)
> live, with an optional "hide text" aid for memorization.

**Status:** `En cours` — frontend livré ; validation device + backend live à faire.
**Module:** Home · **Feature:** 1.7 · **Tracker:** [IMPLEMENTATION-TRACKER.md](../../IMPLEMENTATION-TRACKER.md) → Feature 1.7

---

## What this is

Feature 1.6 (`recitation-test`) proved the AI pipeline (Flutter mic ⇄ Django Channels ⇄
Deepgram, per-word verdicts) on a throwaway Al-Fatiha screen. **Feature 1.7 brings that
capability into the real Quran page** (`lib/src/features/home/quran/page/`): the verdicts
recolor the **actual rendered mushaf words in place**, and a persistent **bottom app bar**
turns the page into a recitation/memorization workspace.

The **same backend WebSocket contract** as 1.6 is reused unchanged (see
[recitation-test/design.md §3](../recitation-test/design.md)); only the frontend is new.

## Scope of v1

- **Page-scoped** recitation: the words currently rendered on the visible page; auto-stops
  when the page is finished.
- **Two extra entry points kept alongside:** the per-verse popup mic (recite from a verse to
  the end of the surah — Feature 1.6 behavior, reused) and a floating button to start from a
  **specific selected position** on the page.
- **Memorization "hide text"** aid: words hidden, each revealed in its verdict color once
  recited.
- **Letters-only matching** and the streaming alignment are inherited from the backend (1.6);
  no new server logic.

## Documents

| File | Purpose |
|------|---------|
| [`requirements.md`](./requirements.md) | The WHAT & WHY — user stories (INVEST) + acceptance criteria (EARS) + scope |
| [`design.md`](./design.md) | The HOW — page-scoped flow, control bar, hide-text, auto-stop, module map |
| [`tasks.md`](./tasks.md) | Implementation breakdown — frontend (Flutter) + verification |

## Related project docs

- [`docs/specs/recitation-test/`](../recitation-test/) — Feature 1.6, the reused AI pipeline + WebSocket contract.
- [`CLAUDE.md`](../../../CLAUDE.md) — codebase contract (architecture, hard rules).
- [`DESIGN_SYSTEM.md`](../../../DESIGN_SYSTEM.md) — UI tokens (read before any UI work).
- [`docs/commercial/LISTE-DES-FONCTIONS.md`](../../commercial/LISTE-DES-FONCTIONS.md) — product spec (Feature 1.7).
