# VibeCoding Guide — Tajweed AI

> A practical guide to the methodology used to build this project with Claude Code.
> The docs are the contract. The skills are the workflow. Claude Code is the operator.

This guide is written for you to learn the system end-to-end and apply it on **Tajweed AI** specifically. It covers only the **implementation framework** (what's already in this repo). The upstream "commercial framework" (`/analyze-need`, `/generate-functions`, `/generate-baseline`) is mentioned only as the source of `LISTE-DES-FONCTIONS.md`.

---

## Table of contents

1. [Mental model](#1-mental-model)
2. [The four core docs](#2-the-four-core-docs)
3. [Glossary (read his French templates without confusion)](#3-glossary)
4. [The skill loop](#4-the-skill-loop)
5. [Hard rules — non-negotiable](#5-hard-rules)
6. [End-to-end walkthrough on Tajweed AI](#6-end-to-end-walkthrough-on-tajweed-ai)
7. [i18n integration](#7-i18n-integration)
8. [5-minute exercise — add a feature today](#8-5-minute-exercise)
9. [Pitfalls](#9-pitfalls)
10. [Appendix A — file roles cheat sheet](#appendix-a--file-roles-cheat-sheet)
11. [Appendix B — skill quick reference](#appendix-b--skill-quick-reference)

---

## 1. Mental model

VibeCoding works because **the project state lives in markdown files, not in your head**.

- `CLAUDE.md` tells Claude how to write code in this repo (commands, architecture, hard rules).
- `DESIGN_SYSTEM.md` tells Claude what visual tokens to use.
- `docs/commercial/LISTE-DES-FONCTIONS.md` tells Claude **what** to build (features + user stories).
- `docs/IMPLEMENTATION-TRACKER.md` tells Claude **what's next** and **what's done**.

The **skills** (`/add-feature`, `/workflow-start-implementation`, `/review`, etc.) are short, single-purpose playbooks installed in `~/.claude/skills/`. Each skill reads a small set of files, does one thing, and updates the trackers.

You — the human — stay in the loop **only at decision points**:

- "Add this feature to Set 1 or Set 2?"
- "Continue with the Frontend, or pause?"
- "Apply this refactor plan?"

Everything else (branch naming, commit messages, tracker ticks, review, PR creation) is automated by the skills.

---

## 2. The four core docs

### 2.1 `CLAUDE.md` — the codebase contract

**Loaded into every Claude Code session in this repo.** It tells Claude:

- The commands you actually run (`flutter pub get`, `flutter run`, `dart run build_runner build --delete-conflicting-outputs`, …)
- The layer structure (`lib/src/app/`, `base/`, `core/`, `database/`, `features/`, `helpers/`)
- The feature module shape (`binding/`, `data/`, `router/`, `vm/`)
- The key abstractions (`Feature<B,S>`, `BaseBloc<E,S>`, `Dependencies`, `di` / `get<T>()`)
- The **hard rules** Claude cannot break. From this project:
  - **Design system** — no hardcoded colors, font sizes, dimensions, asset strings, or raw `TextStyle(...)`.
  - **i18n** — no raw user-facing strings in widgets; every key must exist in BOTH `app_en.arb` and `app_ar.arb`; AppBars are LTR-locked; the Quran `PageView` is RTL-locked.
- The "session-specific guidance" (e.g. `main.dart` currently hardcodes `/quran-listing` as the dev route — don't be confused by that).

> **Why this matters:** when you start a new Claude Code session, you don't have to re-explain the project. Claude reads `CLAUDE.md` and knows the rules. The hard rules are framed as **"no exceptions"** so Claude refuses to break them.

**Who writes it:** the human (you), at project birth and whenever a new permanent rule emerges.
**Who reads it:** Claude Code, automatically, every session.

### 2.2 `DESIGN_SYSTEM.md` — the visual contract

**Single source of truth for UI tokens.** Referenced from `CLAUDE.md` with a hard rule: _"Read DESIGN_SYSTEM.md before writing any UI code."_

It defines:

- `AppColors.*` — gold-based palette (primary `#D4AF37`, secondary `#F4E4BC`, scaffold white, greyDarkest `#413E40`, etc.) plus gradients.
- `AppFonts.*` — six font families (Lato, Poppins, Nunito, Helvetica, UthmanicHafsV18, SurahNameV4).
- `FontSizes.*` — semantic scale (`headline1` 24 → `caption` 10).
- `TextStyleExt` — chainable modifiers: `AppFonts.lato.withSize(FontSizes.subtitle).withColor(AppColors.greyDarkest).medium()`.
- `AppMetrics.*` — spacing scale (`xs` 8 → `xxl` 64), scaffold padding, topBar/bottomBar/buttons/inputs metrics, and component-specific blocks (`AppMetrics.lastSelectedSurahWidget`, `AppMetrics.surahNameCard`).
- `tajweedStyleMap` — the 12 Tajweed rule colors used by the Quran renderer.
- `AppImages.*` — asset path constants.

The convention: **chain from a font constant**, never write a raw `TextStyle`. Example from the codebase:

```dart
Text(
  "Last read",
  style: AppFonts.lato
      .withSize(FontSizes.indication)
      .withColor(AppColors.greyDarkest)
      .medium(),
)
```

**Who writes it:** the human, with `/workflow-design-system` (or directly).
**Who reads it:** Claude, before any frontend session.

> Note: the `/workflow-design-system` skill is templated for Tailwind/Next.js projects. For Tajweed AI (Flutter), the equivalent is just editing `DESIGN_SYSTEM.md` directly and registering new tokens in `lib/src/app/design/`. The _principle_ is the same: never let Claude pick a hex code or a number.

### 2.3 `docs/commercial/LISTE-DES-FONCTIONS.md` — the product spec

The **"function file."** A non-ordered catalog of everything the product does, structured as:

```
Module → Feature (X.Y) → User Story (US-X.Y.Z)
```

Each User Story follows the **INVEST** format ("En tant que… je veux… afin de…") and is **sized**:

| Taille | Effort   |
| ------ | -------- |
| XS     | 0.25 day |
| S      | 0.5 day  |
| M      | 1 day    |
| L      | 2 days   |
| XL     | 3 days   |

The current Tajweed AI version has 2 modules (Auth, Home), 5 features, 20 user stories, ~15 days of effort. A real example from the file:

```markdown
### Feature 1.3 - Home Screen (Chooser)

- Complexite : Simple
- Description : Ecran d'accueil minimaliste qui permet a l'utilisateur de choisir
  entre deux parcours principaux : la lecture du Coran ou les cours Tajweed.
- Lot : Set 1

| ID       | User Story                                                            | Taille | Jours |
| -------- | --------------------------------------------------------------------- | ------ | ----- |
| US-1.3.1 | … voir un ecran d'accueil avec deux options (Coran / Cours Tajweed) … | S      | 0.5   |
| US-1.3.2 | … taper sur "Coran" pour ouvrir la liste des sourates …               | XS     | 0.25  |
| US-1.3.3 | … taper sur "Cours Tajweed" pour ouvrir l'ecran des cours …           | XS     | 0.25  |
| US-1.3.4 | … un header avec accueil personnalise (nom / salutation) …            | S      | 0.5   |

- Effort total : 1.5 jours
- Dependances : Feature 1.5 (Quran Listing), Feature 1.4 (Tajweed Courses)
```

**Who writes it:** initially the human (or the upstream commercial framework). Subsequently, only via `/add-feature` — never by hand.
**Who reads it:** Claude, when implementing or when adding a new feature.

### 2.4 `docs/IMPLEMENTATION-TRACKER.md` — the execution tracker

The **operational view**. Where the product spec gets turned into actionable work.

Structure:

- **Dashboard** — total features, total US, total effort, active Set, global progression.
- **Status par Set** — table of all Sets and their status.
- **Set N** sections — each Set holds **max 5 features**. Each feature shows status, module, effort, complexity, location, backend tasks (checkboxes), frontend tasks (checkboxes).
- **Backlog "Features Ajoutees"** — table of every feature added with date and source.
- **Journal de bord** — the _why_ log. Every spec change gets an entry explaining the rationale.

Real journal entry from this project:

```markdown
### 2026-05-18 - Refactor Feature 1.3 + ajout Feature 1.5

- Action : Decoupage de l'ancienne Feature 1.3 en deux features distinctes
- Feature 1.3 (nouvelle) : Home Screen (Chooser) — landing page avec choix
- Feature 1.5 (nouvelle) : Quran Listing — extrait de l'ancien 1.3
- Set : Set 1 — passe a 5/5 features (cap atteint)
- Raison : Demande utilisateur d'avoir un vrai ecran d'accueil chooser
- Impact technique : main.dart (initialRoute) et AppRouter devront pointer
  vers /home au lieu de /quran-listing
```

**Who writes it:** `/add-feature` and `/workflow-start-implementation`. Never edit by hand.
**Who reads it:** Claude, at the start of every implementation session.

---

## 3. Glossary

So you can read your colleague's French templates without confusion.

| Term                | Meaning                                                                                                                                                                                    |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Module**          | Top-level functional area (e.g. Auth, Home).                                                                                                                                               |
| **Feature**         | Numbered deliverable (`Feature 1.3`). Lives inside a module. Decomposed into User Stories.                                                                                                 |
| **User Story (US)** | INVEST-format functional requirement (`US-1.3.1`). "En tant que… je veux… afin de…"                                                                                                        |
| **Taille**          | Size: XS / S / M / L / XL → 0.25 / 0.5 / 1 / 2 / 3 jours.                                                                                                                                  |
| **Effort**          | Sum of US sizes for a feature.                                                                                                                                                             |
| **Complexite**      | Simple (≤ 2 j) / Moyenne (2–5 j) / Complexe (> 5 j). Derived from effort.                                                                                                                  |
| **Dependances**     | Other features this one needs before it can be built.                                                                                                                                      |
| **Set**             | Implementation grouping of **≤ 5 features**. The cap is hard — never put 6 in one Set.                                                                                                     |
| **Lot**             | Commercial-side grouping (L0, L1, L2, L3, LX). One Lot maps to one or several Sets.                                                                                                        |
| **Entree BASELINE** | A row in the BASELINE = Feature + the specific US to implement (e.g. `Feature 6.1 (US 1-6)`). The unit of work for one session. Tajweed AI is solo + simple, so each feature is one entry. |
| **Ressource**       | A developer, identified by initials (e.g. ON, AK). On Tajweed AI, you're the only one.                                                                                                     |
| **Journal de bord** | Append-only log inside `IMPLEMENTATION-TRACKER.md`. Every spec change writes an entry with the why.                                                                                        |
| **TDD**             | Test-Driven Development: RED → GREEN → REFACTOR. Always.                                                                                                                                   |

---

## 4. The skill loop

Skills live in `~/.claude/skills/` and are invoked with `/<skill-name>` in Claude Code. Here's the loop, in the order you'll use them on Tajweed AI.

```
        +--------------------+         +----------------------------------+
        |   /add-feature     | ------> |  /workflow-start-implementation  |
        +--------------------+         +----------------------------------+
                  |                                   |
                  | updates                           | reads tracker,
                  |  LISTE-DES-FONCTIONS              | implements ONE side
                  |  IMPLEMENTATION-TRACKER           | of ONE entry in TDD
                  v                                   v
        +--------------------+         +--------------+    +------------------------+
        |  journal de bord   |         |   /review    |--> |  /workflow-git-workflow|
        +--------------------+         +--------------+    |  (commit / pr / merge) |
                                                            +------------------------+
                                                                       |
                                                                       v
                                                            +------------------------+
                                                            | next entry, next side  |
                                                            +------------------------+
```

### 4.1 `/add-feature "<description>"`

Adds a feature mid-project.

**What it does:**

1. Reads `IMPLEMENTATION-TRACKER.md` (progression, current Set) and `LISTE-DES-FONCTIONS.md` (existing modules and US).
2. Identifies the right module, decomposes the request into User Stories in INVEST format, sizes each US.
3. Proposes a placement: add to current Set (if < 5), add to a future Set, or create a new Set. **Asks you** which to pick.
4. Updates `LISTE-DES-FONCTIONS.md` (adds the feature and its US, updates the totals).
5. Updates `IMPLEMENTATION-TRACKER.md` (adds the feature with empty backend/frontend checkboxes, updates the dashboard, appends a journal entry with "Raison : Demande utilisateur").

**Hard rule:** a Set never exceeds 5 features. If you try, it forces you to spawn a new Set.

**Example invocation:**

```
/add-feature Settings screen with theme toggle (light/dark)
```

### 4.2 `/workflow-start-implementation`

Implements **one side** (Backend OR Frontend) of **one entry** of one feature.

**What it does:**

1. Detects the resource (in solo Tajweed AI, it's just you).
2. Reads the tracker, identifies the next entry (or the entry you specified as arg), checks dependencies.
3. Detects the type: `BACKEND-ONLY` / `FRONTEND-ONLY` / `FULLSTACK`. For FULLSTACK, it always does **Backend first**, then Frontend in a later session.
4. Loads only the reference docs for the side it's about to implement (saves context — never both at once).
5. Creates the git branch: `feat/<initials>-f<X.Y>-us<Z1-Z2>` (e.g. `feat/IB-f1.3-us1-4`).
6. For Frontend: reads `DESIGN_SYSTEM.md` to know the tokens to use.
7. Implements in **TDD** (RED → GREEN → REFACTOR), ticking each technical task in the tracker as it goes.
8. Runs `/review` on the diff.
9. Commits with Conventional Commits format.
10. Asks you: "Continue with the other side?" or "Continue with the next entry?" or "Pause?"

**Never** does both Backend and Frontend in the same session. **Never** implements US outside the current entry.

### 4.3 `/review [files]`

Quality gate before every commit. Replaces a human reviewer.

**What it checks (per file):**

- **Quality** — naming, DRY, simplicity, types, unused imports, dead code.
- **Patterns** — separation of concerns, consistency with existing patterns, file < 300 lines, function < 50 lines, single responsibility.
- **Security** — no SQL injection, no `dangerouslySetInnerHTML`, no hardcoded secrets, input validation, auth on protected endpoints.
- **Tests** — new code is tested, tests verify behavior (not implementation), descriptive test names.

**Output:** a categorized report — `✓ OK`, `⚠ Suggestions`, `✗ A corriger` — and then asks if you want it to apply fixes automatically.

> If `/review` flags issues during `/workflow-start-implementation`, the skill fixes them and re-runs the review until it's clean. Then commits.

### 4.4 `/refactor [scope]`

Refactor with safety net: tests before, tests after, no behavior change.

**What it does:**

1. Reads the code in scope, identifies dependencies and existing tests.
2. Runs the tests to establish a baseline. **Warns** if tests are already failing.
3. Analyzes and proposes a plan (problem types: DUPLICATION, TAILLE, COUPLAGE, NOMMAGE, COMPLEXITE, RESPONSABILITE).
4. **Asks for approval** before changing anything.
5. Applies changes one at a time, running tests after each. If a test breaks → stops and asks (revert / fix the test / adjust the refactor).
6. Final verification: zero regressions.

### 4.5 `/debug [problem]`

Methodical bug diagnosis.

**What it does:**

1. Reads the problem description, classifies scope (BACKEND / FRONTEND / FULLSTACK).
2. Collects clues — error message, traceback, relevant files (model, serializer, view, urls — or component, hook, store).
3. Forms a hypothesis with evidence. Max 3 hypotheses before asking you for more info.
4. Proposes the fix, asks for approval, applies, runs tests.
5. Suggests adding a regression test if none existed.

### 4.6 `/workflow-git-workflow [subcommand]`

Full git lifecycle for an entry. Subcommands:

- `create-branch` — `git checkout main && git pull && git checkout -b feat/<initials>-f<X.Y>-us<Z1-Z2>`
- `commit` — sanitizes (no secrets, no generated files), picks the right Conventional Commits type, includes the tracker file in the commit.
- `pr` — runs `/review`, pushes, opens a PR with structured body (Entree BASELINE block, Changes, Tests, Review checklist), auto-merges.
- `sync` — stashes, pulls main, rebases. Resolves tracker conflicts in favor of the most-progressed version.
- `status` — current branch, modified files, all your branches, open PRs.

**Branch convention recap:**

```
feat/<INITIALS>-f<X.Y>-us<Z1-Z2>
```

| Prefix    | Use case                           |
| --------- | ---------------------------------- |
| `feat/`   | BASELINE entries (the default)     |
| `bugfix/` | Bug fixes outside a BASELINE entry |
| `hotfix/` | Emergency fixes                    |
| `chore/`  | Maintenance (deps, config)         |

### 4.7 `/workflow-sync-trackers`

**Not used in Tajweed AI today** (solo project, one tracker). Documented here for when you scale to a team.

In team setups, every developer has their own `docs/TRACKER-XX.md` (e.g. `TRACKER-ON.md` for Oumayma, `TRACKER-AK.md` for Aziza). `/workflow-sync-trackers` reads all of them and regenerates `docs/IMPLEMENTATION-TRACKER.md` as the consolidated, read-only global view.

Rules:

- Never edit the individual trackers from another resource.
- Never edit `IMPLEMENTATION-TRACKER.md` by hand — regenerate it.

### 4.8 Skills not covered in depth

- `/workflow-init-project` — used **once**, at project birth, to bootstrap from commercial deliverables. Not relevant for Tajweed AI now (already initialized).
- `/workflow-design-system` — templated for Tailwind/Next.js. On Tajweed AI, edit `DESIGN_SYSTEM.md` and `lib/src/app/design/` directly.
- `/workflow-deploy` — used only when shipping releases.

---

## 5. Hard rules

These are non-negotiable. Most of them are encoded inside the skills themselves and self-enforced.

### Process rules

1. **One side per session.** Never implement Backend and Frontend in the same `/workflow-start-implementation` call. For FULLSTACK entries: Backend first, Frontend in the _next_ session.
2. **One entry per session.** Never implement two features back-to-back without confirmation.
3. **Only the specified US.** If the entry says `Feature 6.1 (US 1-6)`, do _not_ implement US 7-9. Those belong to another entry, another session.
4. **Max 5 features per Set.** Caps enforced by `/add-feature`.
5. **TDD always.** RED → GREEN → REFACTOR. Tests are not optional.
6. **`/review` before every commit.** No exceptions, no "I'll review later."

### File rules

7. **Tracker is the truth.** Update `IMPLEMENTATION-TRACKER.md` after every technical task — not at the end. Progression is measured in tasks ticked, not in features completed.
8. **Never edit `IMPLEMENTATION-TRACKER.md` by hand** (in team setups). Use `/add-feature` or `/workflow-sync-trackers`.
9. **Every spec change journals the why.** No silent edits. Date, action, reason, impact.
10. **Both ARB files in lockstep.** Add a key to `app_en.arb`? Same edit adds the Arabic translation in `app_ar.arb`. Otherwise it's a compile error.

### Code rules (from `CLAUDE.md`)

11. No hardcoded colors → `AppColors.*`.
12. No hardcoded font sizes → `FontSizes.*`.
13. No hardcoded dimensions → `AppMetrics.*`.
14. No raw asset strings → `AppImages.*`.
15. No raw `TextStyle(...)` → start from `AppFonts.*` and chain.
16. No raw user-facing strings → `AppLocalizations.of(context)!.<key>`.
17. AppBars are LTR-locked (`Directionality(textDirection: TextDirection.ltr, ...)`).
18. The Quran `PageView` is RTL-locked, regardless of locale.

### Git rules

19. Branch convention: `feat/<initials>-f<X.Y>-us<Z1-Z2>`.
20. Conventional Commits: `feat`, `fix`, `test`, `refactor`, `docs`, `style`, `chore` with a scope.
21. Never push to `main` directly. Never `git push --force` to `main`.
22. The tracker file is always included in the commit (it's part of the code).
23. No generated files (`__pycache__`, `node_modules`, `build/`, `.dart_tool/`) committed.
24. No secrets (`.env`, credentials) committed.

---

## 6. End-to-end walkthrough on Tajweed AI

Concrete example using the project's actual state (Set 1, all 5 features still `A faire`).

### Initial state

From `docs/IMPLEMENTATION-TRACKER.md`:

```
Set 1 - Finalisation MVP Auth & Home
Features : 5/5 (cap atteint)
Effort   : 15 jours

[1.1] Sign In         - A faire (partiellement implemente) - 4.25 j - FULLSTACK
[1.2] Sign Up         - A faire (partiellement implemente) - 4.25 j - FULLSTACK
[1.3] Home Screen     - A faire (nouvelle feature)         - 1.5 j  - FRONTEND-ONLY
[1.4] Tajweed Courses - A faire (nouvelle feature)         - 3 j    - FULLSTACK
[1.5] Quran Listing   - A faire (partiellement implemente) - 2 j    - FRONTEND-ONLY (depuis prebuilt.db)
```

Let's implement **Feature 1.3 — Home Screen (Chooser)** because it's small (4 US, 1.5 j, FRONTEND-ONLY) and it unblocks navigation to 1.4 and 1.5.

### Step 1 — start the session

You type, in Claude Code (already in this repo):

```
/workflow-start-implementation Feature 1.3
```

Claude does (in this order):

1. Lists `docs/TRACKER-*.md` — finds only `IMPLEMENTATION-TRACKER.md`, treats it as the single tracker.
2. Reads `docs/IMPLEMENTATION-TRACKER.md` — sees Feature 1.3 is `A faire`, has only frontend tasks → type = `FRONTEND-ONLY`, side this session = `FRONTEND`.
3. Reads `docs/commercial/LISTE-DES-FONCTIONS.md` — pulls the descriptions of US-1.3.1 to US-1.3.4.
4. Loads `DESIGN_SYSTEM.md` (because the side is Frontend).
5. Loads `CLAUDE.md` rules (always).
6. Skips loading any `docs/reference/*` because the folder doesn't exist (Tajweed AI variant).
7. Displays:

```
=== Docs loaded ===
- CLAUDE.md ✓
- DESIGN_SYSTEM.md ✓ (Frontend session)
- IMPLEMENTATION-TRACKER.md ✓
- LISTE-DES-FONCTIONS.md ✓

=== Implementation — Tajweed AI ===
Set 1 - Finalisation MVP Auth & Home
Next entry: Feature 1.3 - Home Screen (Chooser)  <-- THIS SESSION
US: 1.3.1, 1.3.2, 1.3.3, 1.3.4 (4 US, 1.5 j)
Type: FRONTEND-ONLY
Side this session: FRONTEND
```

### Step 2 — branch + tracker status

```bash
git checkout main
git pull
git checkout -b feat/IB-f1.3-us1-4
```

(Replace `IB` with your initials. On a solo project, this can also be your handle.)

Then it updates the tracker:

```markdown
### [Feature 1.3] Home Screen (Chooser)

- Status : En cours - Frontend
- Started : 2026-05-19 14:23
  ...
```

### Step 3 — TDD per US

For each US (1.3.1 → 1.3.4), it:

1. Writes the widget test first (RED).
2. Implements the widget using `AppColors`, `AppFonts.lato`, `AppMetrics.spacing.sm`, etc. — never raw values.
3. Adds the localization keys to **both** `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb` (see §7).
4. Runs `flutter test` for that file — must pass (GREEN).
5. Optional REFACTOR pass.
6. Ticks the checkbox in `IMPLEMENTATION-TRACKER.md`:

   ```markdown
   - [x] US-1.3.1 : Ecran avec 2 cards/boutons (Coran / Cours Tajweed) (S)
   ```

7. Commits:

   ```
   feat(home): add chooser screen with Coran/Cours Tajweed cards (US-1.3.1)
   ```

### Step 4 — wire navigation + main.dart

US-1.3.2 and US-1.3.3 add routes and navigation. The skill also handles:

- Add `/home` route to `lib/src/app/router/app_router.dart`.
- Update `AppConfig.setInitialRoute()` in `main.dart` to point to `/home` (currently hardcoded to `/quran-listing`).

### Step 5 — pre-commit + auto-review

After the last US:

1. Runs `/review` on every modified file. Checks tokens (no hardcoded colors), AppBar wrapped in `Directionality.ltr`, no raw strings, both ARB files updated.
2. If anything is flagged → fixes it → re-runs `/review` until clean.

### Step 6 — push + PR + merge

```bash
git push -u origin feat/IB-f1.3-us1-4

gh pr create --title "feat: Feature 1.3 Home Screen (Chooser) (US 1-4) - IB" --body "
## Entree BASELINE
- Feature : 1.3 - Home Screen (Chooser)
- US implementees : 1-4
- Set : 1

## Changements
- New widget: lib/src/features/home/home_screen/
- Router: added /home route
- main.dart: updated initialRoute to /home
- ARB: added homeChooseCoran, homeChooseTajweed, homeGreeting in en+ar

## Tests
- [x] 4 widget tests pass
- [x] Tracker updated

## Review
- [x] /review : OK
"

gh pr merge --merge
```

### Step 7 — tracker final state + journal

Feature 1.3 status flips to `Termine`. Progression recalculates. A new journal entry is appended:

```markdown
### 2026-05-19 - Feature 1.3 terminee

- Action : Implementation complete de Feature 1.3 (Home Screen Chooser)
- US terminees : 1.3.1, 1.3.2, 1.3.3, 1.3.4
- Set 1 : 1/5 features terminees, progression 20%
- Impact : main.dart pointe maintenant vers /home (avant: /quran-listing)
```

### Step 8 — proposition

```
Que veux-tu faire ?
1. Continuer avec la prochaine entree (Feature 1.4 - Tajweed Courses, Backend d'abord)
2. Pause
```

---

## 7. i18n integration

Tajweed AI has a hard rule layered on top of the standard workflow: **every frontend session ships ARB translations**. This is enforced in `CLAUDE.md` and any new screen will be blocked at `/review` without it.

### Checklist for any frontend session

1. Identify every user-facing string in the new widget. Skip Quranic text (Uthmanic font) and brand names ("Tajweed AI", "Google", "Facebook", "Apple").
2. Add a key to **BOTH** ARB files:
   ```json
   // lib/l10n/app_en.arb
   "homeChooseCoran": "Read the Quran"
   // lib/l10n/app_ar.arb
   "homeChooseCoran": "اقرأ القرآن"
   ```
3. Run `flutter pub get` to regenerate `AppLocalizations`.
4. Reference the key:
   ```dart
   import 'package:tajweed_ai/l10n/app_localizations.dart';
   ...
   final l10n = AppLocalizations.of(context)!;
   Text(l10n.homeChooseCoran);
   ```
5. Wrap the screen's `AppBar` in `Directionality(textDirection: TextDirection.ltr, ...)`.
6. **Do not** add `Directionality(textDirection: TextDirection.rtl, ...)` in the body. The locale drives it automatically.
7. For locale-aware model fields (e.g. `Surah.nameSimple` vs `Surah.nameArabic`):
   ```dart
   final isArabic = Localizations.localeOf(context).languageCode == 'ar';
   final display = isArabic ? surah.nameArabic : surah.nameSimple;
   ```
8. For Bloc-emitted messages: emit a key string or a sealed `ErrorReason`, not raw human text. The view is the only place that calls `AppLocalizations.of(context)`.
9. Run `flutter analyze` — zero new issues.
10. Manually toggle Arabic in `/settings` and verify the screen flips correctly.

**Why this matters:** missing keys become **compile errors**, not runtime "not found". This is a feature, not a bug — it forces the loop to stay synchronized.

---

## 8. 5-minute exercise

Open Claude Code in this repo and run:

```
/add-feature Settings screen with theme toggle (light/dark)
```

Claude will:

1. Read the current tracker. It will see Set 1 is full (5/5 cap atteint).
2. Decompose the request into User Stories — probably something like:
   - US-2.1.1 : View current theme (Light/Dark) on settings screen (S - 0.5j)
   - US-2.1.2 : Toggle theme with immediate effect (M - 1j)
   - US-2.1.3 : Persist theme choice across app restarts (S - 0.5j)
3. Propose placement:
   ```
   Set 1 is full (5/5). Options:
   A) Add to a future Set 2 (recommended)
   B) Replace a Set 1 feature
   C) Create Set 2 now
   ```
4. After you pick — update both `LISTE-DES-FONCTIONS.md` and `IMPLEMENTATION-TRACKER.md`, append a journal entry like:
   ```markdown
   ### 2026-05-19 - Feature ajoutee

   - Feature : Feature 2.1 - Settings Theme Toggle
   - Module : Settings
   - Placee dans : Set 2
   - Effort : 2 jours
   - Raison : Demande utilisateur
   ```

You don't have to implement anything. Just run the command, watch the diff, then `git checkout -- docs/` if you want to discard it.

---

## 9. Pitfalls

Things that look harmless and silently break the system:

| Pitfall                                                  | Why it breaks the loop                                                                                                                   |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Editing `IMPLEMENTATION-TRACKER.md` by hand              | In team mode, this gets overwritten by `/workflow-sync-trackers`. Even solo, it skips the journal entry — you lose the _why_.            |
| Implementing two features in one session                 | Context bloat → Claude forgets the rules halfway through, mixes patterns, breaks the side-isolation rule.                                |
| Skipping `/review` "because the change is small"         | The skill catches subtle violations (a raw color, an untranslated string) that you won't notice in a diff.                               |
| Adding a string to a widget without an ARB key           | Compile error eventually, but worse: forgetting to update `app_ar.arb` ships an English string in the Arabic build.                      |
| Hardcoding `Colors.amber` instead of `AppColors.primary` | Breaks the design system. When the palette changes, your widget doesn't follow.                                                          |
| Forgetting the journal entry on a spec change            | Future-you (or your colleague) reads the tracker and has no idea _why_ the change happened. The most expensive bug is forgotten context. |
| Writing your own `TextStyle(fontSize: 14, ...)`          | Same as hardcoded colors. Always chain from `AppFonts.*`.                                                                                |
| Running `git push --force` on `main`                     | Destroys other people's work. The skills never do this.                                                                                  |
| Implementing US that aren't in the current entry         | "Just one more" creeps into 5 more, the Set explodes, the tracker becomes a lie.                                                         |

---

## Appendix A — file roles cheat sheet

| File                                     | Written by                                          | Read by                                       | Changes when                                     |
| ---------------------------------------- | --------------------------------------------------- | --------------------------------------------- | ------------------------------------------------ |
| `CLAUDE.md`                              | You (manual)                                        | Claude, every session                         | A permanent rule is added/changed                |
| `DESIGN_SYSTEM.md`                       | You (manual) or `/workflow-design-system`           | Claude, every frontend session                | A token is added/changed                         |
| `docs/commercial/LISTE-DES-FONCTIONS.md` | `/add-feature` (or commercial framework initially)  | Claude, every implementation + `/add-feature` | A new feature/US is added                        |
| `docs/IMPLEMENTATION-TRACKER.md`         | `/add-feature` + `/workflow-start-implementation`   | Claude, every implementation                  | After every technical task (checkbox flips)      |
| `docs/VIBECODING-GUIDE.md` (this file)   | You                                                 | You (and future onboardees)                   | The methodology itself evolves                   |
| `lib/l10n/app_en.arb` + `app_ar.arb`     | `/workflow-start-implementation` (Frontend session) | Build, every `flutter pub get`                | A new user-facing string is added                |
| `pubspec.yaml`                           | You (manual) + `flutter pub add`                    | `flutter pub get`                             | A dependency or asset is added                   |
| `lib/src/database/tables/*.dart`         | You                                                 | `dart run build_runner build`                 | Schema changes; bump `AppDatabase.schemaVersion` |

---

## Appendix B — skill quick reference

| Skill                           | Command                                                | Touches                                                       | Preconditions                                  |
| ------------------------------- | ------------------------------------------------------ | ------------------------------------------------------------- | ---------------------------------------------- |
| Add a feature                   | `/add-feature "<desc>"`                                | `LISTE-DES-FONCTIONS.md`, `IMPLEMENTATION-TRACKER.md`         | Tracker + function list exist                  |
| Implement next entry            | `/workflow-start-implementation [Feature X.Y \| next]` | Code, tests, tracker, git branch, ARB files                   | Tracker exists, project initialized            |
| Code review (pre-commit)        | `/review [files]`                                      | Reports only; can apply fixes on request                      | Files modified or staged                       |
| Refactor with safety net        | `/refactor [scope]`                                    | Code; runs tests before/after                                 | Tests exist for scope                          |
| Diagnose a bug                  | `/debug "<problem>"`                                   | Reports, then a single targeted fix                           | A reproducible problem                         |
| Git lifecycle (branch/PR/merge) | `/workflow-git-workflow <sub>`                         | Local git state, remote, PR                                   | `gh` CLI authenticated                         |
| Sync trackers (team mode)       | `/workflow-sync-trackers`                              | Regenerates `IMPLEMENTATION-TRACKER.md`                       | Multiple `TRACKER-XX.md` files exist           |
| Bootstrap a new project         | `/workflow-init-project [template]`                    | Creates project tree from commercial deliverables             | `LISTE-DES-FONCTIONS.md` + `BASELINE.md` exist |
| Define design system (Tailwind) | `/workflow-design-system [style]`                      | `docs/DESIGN.md`, `tailwind.config.js`, `src/components/ui/*` | Project initialized (Tailwind template)        |
| Deploy a release                | `/workflow-deploy`                                     | CI/CD config, release tags                                    | Project ready to ship                          |

---

## Closing thought

The whole methodology fits in one sentence:

> **Write down what the project does, what's next, and why every change happened — then let the skills enforce the discipline.**

The reason vibe-coding works for your colleague is not that he types fast or that Claude is magic. It's that **every state transition is visible in a file**, and **every file has exactly one skill responsible for writing to it**. When you trust that contract, you can build a whole app in a flow state — because you never have to remember anything.
