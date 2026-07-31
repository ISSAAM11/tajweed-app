# Requirements — Quran-Page Recitation (Feature 1.7)

## Context & problem statement

Feature 1.6 validated real-time recitation feedback on a standalone Al-Fatiha screen. But
users read and memorize the Quran on the **reading page**, not on a separate test screen. To
be useful for memorization (ḥifẓ), the feedback has to live where they read: the actual
mushaf words must recolor in place, and the user needs page-level controls — start/stop,
restart, jump forward, and a way to **hide the text** so they recite from memory and only see
a word once they've said it.

This feature reuses the entire Feature 1.6 backend pipeline (Django Channels ⇄ Deepgram,
letters-only online alignment, per-word verdicts) **without change**; all the work is in the
Flutter Quran-page layer.

---

## User stories (INVEST)

> Sizes: XS (0.25j), S (0.5j), M (1j), L (2j), XL (3j).

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.7.1 | En tant qu'utilisateur, je veux activer un "mode récitation" depuis une barre en bas de la page Coran afin d'entraîner ma récitation sur la page affichée | S | 0.5 |
| US-1.7.2 | En tant qu'utilisateur, je veux démarrer / arrêter l'enregistrement depuis la barre afin de contrôler ma session | S | 0.5 |
| US-1.7.3 | En tant qu'utilisateur, je veux que les mots réellement affichés sur la page deviennent verts (correct) ou rouges (faux) en temps réel afin d'avoir un retour immédiat sans changer d'écran | M | 1 |
| US-1.7.4 | En tant qu'utilisateur, je veux masquer le texte de la page (chaque mot ne se révèle qu'une fois récité, dans sa couleur de verdict) afin de m'auto-tester pour la mémorisation | M | 1 |
| US-1.7.5 | En tant qu'utilisateur, je veux un bouton "recommencer" qui remet le pointeur au début de la page afin de réessayer la page | XS | 0.25 |
| US-1.7.6 | En tant qu'utilisateur, je veux un bouton "suivant" qui saute à la sourate suivante afin d'enchaîner les courtes sourates | S | 0.5 |
| US-1.7.7 | En tant qu'utilisateur, je veux que l'enregistrement s'arrête automatiquement quand la page est terminée afin de ne pas avoir à l'arrêter manuellement | S | 0.5 |
| US-1.7.8 | En tant qu'utilisateur, je veux démarrer la récitation depuis une position précise via un bouton flottant (à partir du verset sélectionné) afin de reprendre où je veux | S | 0.5 |

- **Effort total** : ~4.75 jours (frontend). Backend réutilisé de la Feature 1.6 (aucun nouveau code serveur).
- **Dépendances** : Feature 1.6 (contrat WebSocket + backend Django/Deepgram). Page Coran existante (`quran/page`).

---

## Acceptance criteria (EARS)

**US-1.7.1 — Recitation mode entry**
- WHEN the user opens a Quran page, THE SYSTEM SHALL show a bottom app bar with a "start
  recitation" affordance.
- WHEN the user taps it, THE SYSTEM SHALL enter recitation mode and expand the bar into the
  control surface (record, hide-text, restart, next, exit).
- WHEN the user taps exit, THE SYSTEM SHALL leave recitation mode, stop any recording, and
  clear all verdict coloring.

**US-1.7.2 — Recording control**
- WHEN the user taps record and the page has recitable words, THE SYSTEM SHALL request mic
  permission if needed, then stream audio and switch the icon to "stop".
- IF mic permission is denied or the socket fails, THE SYSTEM SHALL show a localized error and
  remain in mode without recording.
- WHEN the user taps stop, THE SYSTEM SHALL stop streaming and keep the current coloring.

**US-1.7.3 — In-place verdicts**
- WHILE recording, WHEN an interim verdict arrives, THE SYSTEM SHALL tint the matching rendered
  word tentatively; WHEN a verdict is final, THE SYSTEM SHALL lock the glyph to green/red.
- THE SYSTEM SHALL map verdicts to words by the rendered `WordRow.id` so coloring stays correct
  across page swipes.

**US-1.7.4 — Hide-text memorization**
- WHEN hide-text is on, THE SYSTEM SHALL hide every page word (neutral placeholder) and reveal
  each only once it has a verdict, in its verdict color, keeping it revealed.
- WHEN hide-text is off, THE SYSTEM SHALL show the normal text and color verdicts on it.

**US-1.7.5 — Restart**
- WHEN the user taps restart, THE SYSTEM SHALL clear verdicts and restart the session from the
  first word of the current page.

**US-1.7.6 — Next surah**
- WHEN the user taps next, THE SYSTEM SHALL navigate to the first page of the next surah (capped
  at 114) and reset the session for that page.

**US-1.7.7 — Auto-stop on completion**
- WHEN every recitable word on the page has a final verdict, THE SYSTEM SHALL stop recording
  automatically and keep the coloring on screen.

**US-1.7.8 — Start from a position**
- WHEN a verse is selected and the user taps the floating button, THE SYSTEM SHALL enter mode
  and start recitation from that verse's first word through the rest of the page.

---

## Out of scope (v1)

- New backend / matching logic (entirely reused from Feature 1.6).
- Auto-advancing to the next page when one finishes (manual next/swipe only).
- Cross-page single session accumulation beyond what the shared verdict map already provides.
- Tashkeel-sensitive or tajweed-rule scoring; audio storage / history.
