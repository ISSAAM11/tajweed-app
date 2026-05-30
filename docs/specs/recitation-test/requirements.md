# Requirements — Recitation Test (Feature 1.6)

## Context & problem statement

Learners reading the Quran have no immediate feedback on whether they are reciting and
spelling each word correctly. This feature gives them a **practice screen** where they recite
a short surah aloud and get **live, word-by-word feedback**: each word turns green when
recited correctly and red when wrong or skipped.

The first version deliberately keeps the *matching* simple (letters only, true/false per
word) so the effort goes into proving the **AI integration architecture** end to end — live
microphone streaming, Deepgram speech-to-text via a Django backend, and online word
alignment — on a single static screen with one short surah (Al-Fatiha).

---

## User stories (INVEST)

> Sizes: XS (0.25j), S (0.5j), M (1j), L (2j), XL (3j).

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.6.1 | En tant qu'utilisateur, je veux ouvrir l'écran "Recitation Test" depuis la home afin de m'entraîner à réciter | XS | 0.25 |
| US-1.6.2 | En tant qu'utilisateur, je veux voir la sourate affichée mot par mot dans une couleur neutre afin de savoir ce que je dois réciter | S | 0.5 |
| US-1.6.3 | En tant qu'utilisateur, je veux démarrer et arrêter l'enregistrement (avec gestion de la permission micro) afin de contrôler ma session | S | 0.5 |
| US-1.6.4 | En tant qu'utilisateur, je veux que chaque mot devienne vert (correct) ou rouge (faux) en temps réel pendant que je récite afin d'avoir un retour immédiat | M | 1 |
| US-1.6.5 | En tant qu'utilisateur, je veux réinitialiser la session pour réessayer afin de m'entraîner plusieurs fois | XS | 0.25 |

- **Effort total** : 2.5 jours (frontend). Backend Django + intégration Deepgram comptés séparément.
- **Dépendances** : aucune côté navigation ; la validation complète nécessite le backend Django + Deepgram.

---

## Acceptance criteria (EARS)

**US-1.6.1 — Entry point**
- WHEN the user taps the "Recitation Test" action on the home grid, THE SYSTEM SHALL navigate
  to the `/recitation-test` screen.

**US-1.6.2 — Surah rendering**
- WHEN the screen opens, THE SYSTEM SHALL load Al-Fatiha's words from the local prebuilt DB
  and display them in the Uthmani font in a neutral color.
- THE SYSTEM SHALL render the body right-to-left for Arabic word flow.

**US-1.6.3 — Recording control**
- WHEN the user taps "Start", THE SYSTEM SHALL request microphone permission if not yet
  granted, then begin streaming audio and switch the button to "Stop".
- IF microphone permission is denied, THE SYSTEM SHALL show a localized error and remain in
  the idle state.
- WHEN the user taps "Stop", THE SYSTEM SHALL stop streaming and close the session.

**US-1.6.4 — Live verdicts**
- WHILE recording, WHEN an interim verdict for a word arrives, THE SYSTEM SHALL show that
  word in a tentative color (not yet committed).
- WHEN a verdict is marked final, THE SYSTEM SHALL lock that word to green (correct) or red
  (incorrect/skipped).
- IF the connection or microphone fails, THE SYSTEM SHALL transition to an error state with a
  localized message and allow retry.

**US-1.6.5 — Reset**
- WHEN the user taps "Try Again", THE SYSTEM SHALL clear all verdicts and return every word
  to the neutral color, ready for a new session.

---

## Out of scope (v1)

- Strict / tashkeel-sensitive matching (letters only for now).
- Phoneme- or tajweed-rule-based scoring.
- Multiple surahs / surah selection (static Al-Fatiha only).
- Reconnect / resume on a dropped socket; audio storage or history.
- Authentication on the WebSocket (must be added before production).
