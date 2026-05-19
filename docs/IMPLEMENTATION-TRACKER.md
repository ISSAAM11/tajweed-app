# Implementation Tracker - Tajweed AI

> Suivi de l'implementation feature par feature, organise en Sets de 5 features max.
> Voir [docs/commercial/LISTE-DES-FONCTIONS.md](./commercial/LISTE-DES-FONCTIONS.md) pour les specs User Stories.

---

## Dashboard

- **Total features** : 6
- **Total User Stories** : 24
- **Effort total** : 18 jours
- **Set actif** : Set 1
- **Progression globale** : 0% (0/6 features terminees)

### Status par Set

| Set | Objectif | Features | Status |
|-----|----------|----------|--------|
| Set 1 | Finalisation MVP - Auth & Home | 5/5 | En cours (cap atteint) |
| Set 2 | Polish & Personnalisation | 1/5 | A faire |

---

## Set 1 - Finalisation MVP Auth & Home

**Objectif** : Terminer les ecrans de base (login, inscription, home) et ajouter l'acces aux cours Tajweed pour livrer un MVP fonctionnel.

**Status** : En cours
**Features** : 5/5 (cap atteint)
**Effort** : 15 jours

### [Feature 1.1] Sign In (Login)

- **Status** : A faire (partiellement implemente)
- **Module** : Auth
- **Effort** : 4.25 jours (5 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/features/auth/2_sign_in/`
- **Backend** :
  - [ ] US-1.1.1 : Endpoint /auth/sign-in (email + password) (M)
  - [ ] US-1.1.4 : Endpoint /auth/forgot-password (S)
  - [ ] US-1.1.5 : Integration OAuth Google + Apple (L)
  - [ ] Tests backend
- **Frontend** :
  - [ ] US-1.1.1 : Formulaire connexion + appel datasource (M)
  - [ ] US-1.1.2 : Gestion erreurs (snackbars failure/warning) (S)
  - [ ] US-1.1.3 : Bouton "Continuer en invite" (usecase deja amorce) (XS)
  - [ ] US-1.1.4 : Ecran "Mot de passe oublie" (S)
  - [ ] US-1.1.5 : Boutons social login (Google/Apple) (L)
  - [ ] Tests frontend

### [Feature 1.2] Sign Up

- **Status** : A faire (partiellement implemente)
- **Module** : Auth
- **Effort** : 4.25 jours (4 User Stories)
- **Complexite** : Complexe
- **Localisation** : `lib/src/features/auth/3_sign_up/`
- **Backend** :
  - [ ] US-1.2.1 : Endpoint /auth/sign-up (M)
  - [ ] US-1.2.3 : Endpoint /auth/activate-account + envoi email (M)
  - [ ] Tests backend
- **Frontend** :
  - [ ] US-1.2.1 : Stepper 3 etapes (first/second/third step deja crees) (L)
  - [ ] US-1.2.2 : Validation email/password/date/pays (M)
  - [ ] US-1.2.3 : Ecran activation compte (M)
  - [ ] US-1.2.4 : Affichage Terms of Use + checkbox (XS)
  - [ ] Tests frontend

### [Feature 1.3] Home Screen (Chooser)

- **Status** : A faire (nouvelle feature)
- **Module** : Home
- **Effort** : 1.5 jours (4 User Stories)
- **Complexite** : Simple
- **Localisation** : `lib/src/features/home/home_screen/` (a creer)
- **Note** : Cet ecran devient la nouvelle landing page de l'app. Mettre a jour `AppRouter` et l'`initialRoute` dans `main.dart` (actuellement hardcode sur `/quran-listing`).
- **Backend** :
  - [ ] Aucun
- **Frontend** :
  - [ ] US-1.3.1 : Ecran avec 2 cards/boutons (Coran / Cours Tajweed) (S)
  - [ ] US-1.3.2 : Navigation vers `/quran-listing` au tap "Coran" (XS)
  - [ ] US-1.3.3 : Navigation vers `/tajweed-courses` au tap "Cours Tajweed" (XS)
  - [ ] US-1.3.4 : Header avec accueil personnalise (nom + salutation) (S)
  - [ ] Ajouter route `/home` dans `AppRouter`
  - [ ] Mettre a jour `AppConfig.setInitialRoute()` pour pointer vers `/home`
  - [ ] Tests frontend

### [Feature 1.4] Tajweed Courses Screen

- **Status** : A faire (nouvelle feature)
- **Module** : Home
- **Effort** : 3 jours (4 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/features/home/tajweed_courses/` (a creer)
- **Backend** :
  - [ ] US-1.4.1 : Endpoint /courses/list (M)
  - [ ] US-1.4.2 : Endpoint /courses/{id}/progress (S)
  - [ ] Tests backend
- **Frontend** :
  - [ ] US-1.4.1 : ListView des cours (M)
  - [ ] US-1.4.2 : Widget CourseCard (titre, description, progression) (S)
  - [ ] US-1.4.3 : Route `/tajweed-courses` + integration dans AppRouter + navigation depuis home (S)
  - [ ] US-1.4.4 : Bloc + datasource + binding (M)
  - [ ] Tests frontend

### [Feature 1.5] Quran Listing

- **Status** : A faire (partiellement implemente)
- **Module** : Home
- **Effort** : 2 jours (3 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/features/home/quran/listing/`
- **Note** : Anciennement Feature 1.3. Cet ecran n'est plus la home page mais reste accessible via le nouveau Home Screen (Feature 1.3).
- **Backend** :
  - [ ] Aucun (donnees servies depuis prebuilt.db local)
- **Frontend** :
  - [ ] US-1.5.1 : ListView + barre de recherche sur sourates (M)
  - [ ] US-1.5.2 : Card "Derniere sourate consultee" en tete de liste (S)
  - [ ] US-1.5.3 : Navigation vers `/quran-page` au tap (S)
  - [ ] Tests frontend

---

## Set 2 - Polish & Personnalisation

**Objectif** : Ajouter les ecrans de personnalisation et de polish UX qui ameliorent l'experience utilisateur sans bloquer le MVP (themes, preferences, etc.).

**Status** : A faire
**Features** : 1/5
**Effort** : 3 jours

### [Feature 3.1] Settings Theme Toggle

- **Status** : En cours - Frontend
- **Branche** : `feat/IB-f3.1-us1-4`
- **Started** : 2026-05-19
- **Module** : Settings (nouveau module)
- **Effort** : 3 jours (4 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/features/settings/` (existe deja - contient le toggle de langue)
- **Note** : Le dossier `lib/src/features/settings/` existe deja avec le toggle de langue, mais aucune feature Settings n'etait jusqu'ici tracee. Cette feature introduit officiellement le module Settings dans le spec. L'infrastructure `AppThemes.light` + `AppThemes.dark` est deja presente dans `lib/src/app/design/themes/` (dark mode partiel a finaliser via US-3.1.4).
- **Backend** :
  - [ ] Aucun (preference locale, persistance via SharedPreferences)
- **Frontend** :
  - [ ] US-3.1.1 : Section "Apparence" dans Settings avec affichage du theme actuel (S)
  - [x] US-3.1.2 : Toggle/Switch pour basculer light/dark, application immediate via ThemeBloc/Cubit (M) — `lib/src/app/theme/theme_bloc.dart` (Cubit<AppThemeMode> + toggle()) registered as singleton, `MaterialApp.router` rebuilds via `BlocBuilder<ThemeBloc>` + `themeMode` switch, 5 tests
  - [x] US-3.1.3 : `ThemePreferenceService` (pattern `LocalePreferenceService`) - persistance SharedPreferences (S) — `lib/src/core/services/theme_preference_service.dart` + `lib/src/app/theme/app_theme_mode.dart` + 4 tests
  - [x] US-3.1.4 : Finalisation `AppThemes.dark` - palette inversee, contrastes coherents avec gold brand (M) — 6 nouveaux tokens dans `AppColors` (`darkScaffold`, `darkSurface`, `darkSurfaceVariant`, `darkBorder`, `darkTextPrimary`, `darkTextSecondary`), `AppThemes.dark` etendu (colorScheme dark, scaffold, AppBar, card, divider, inputs, dialog, listTile, tooltip, snackbar, chip, textButton), 4 tests, `DESIGN_SYSTEM.md` documente
  - [ ] Cles ARB `settingsTheme`, `settingsThemeLight`, `settingsThemeDark` dans `app_en.arb` + `app_ar.arb`
  - [x] Tests frontend (infrastructure) — `flutter_test` ajoute au pubspec, premier test du projet. `flutter test` complet : 9/9 OK. Tests des autres US a ajouter au fur et a mesure.

---

## Backlog - Features Ajoutees

| Date | Feature | Module | Set | Effort | Source |
|------|---------|--------|-----|--------|--------|
| 2026-05-18 | 1.1 Sign In | Auth | Set 1 | 4.25j | Bootstrap initial |
| 2026-05-18 | 1.2 Sign Up | Auth | Set 1 | 4.25j | Bootstrap initial |
| 2026-05-18 | 1.3 Home Screen (Chooser) | Home | Set 1 | 1.5j | Refactor du 1.3 initial - demande utilisateur |
| 2026-05-18 | 1.4 Tajweed Courses Screen | Home | Set 1 | 3j | Bootstrap initial - demande utilisateur |
| 2026-05-18 | 1.5 Quran Listing | Home | Set 1 | 2j | Extrait de l'ancien 1.3 - n'est plus la home |
| 2026-05-19 | 3.1 Settings Theme Toggle | Settings | Set 2 | 3j | Demande utilisateur (exercice VibeCoding guide) |

---

## Journal de bord

### 2026-05-18 - Bootstrap du tracker
- **Action** : Creation initiale de `docs/IMPLEMENTATION-TRACKER.md` et `docs/commercial/LISTE-DES-FONCTIONS.md`
- **Features ajoutees** : 1.1 Sign In, 1.2 Sign Up, 1.3 Home / Quran Listing, 1.4 Tajweed Courses Screen
- **Set** : Set 1 - Finalisation MVP Auth & Home
- **Raison** : Suivi de l'avancement demande par l'utilisateur (skill `/add-feature`)
- **Note** : Les features 1.1, 1.2 et 1.3 ont deja du code existant dans `lib/src/features/`. La feature 1.4 est entierement nouvelle.

### 2026-05-18 - Refactor Feature 1.3 + ajout Feature 1.5
- **Action** : Decoupage de l'ancienne Feature 1.3 en deux features distinctes
- **Feature 1.3 (nouvelle)** : Home Screen (Chooser) - landing page avec choix entre Coran et Cours Tajweed
- **Feature 1.5 (nouvelle)** : Quran Listing - extrait de l'ancien 1.3, n'est plus la home page
- **Set** : Set 1 - passe a 5/5 features (cap atteint)
- **Raison** : Demande utilisateur d'avoir un vrai ecran d'accueil qui sert de chooser entre Quran Listing et Tajweed Courses
- **Impact technique** : `main.dart` (`initialRoute`) et `AppRouter` devront pointer vers `/home` au lieu de `/quran-listing`

### 2026-05-19 - US-3.1.4 terminee
- **Action** : Finalisation du theme dark de l'app, avec une palette coherente qui preserve le gold brand et inverse les surfaces/greys.
- **Fichiers modifies** :
  - `lib/src/app/design/colors/app_colors.dart` : 6 nouveaux tokens (darkScaffold #1A1A1A, darkSurface #242424, darkSurfaceVariant #2C2C2C, darkBorder #3A3A3A, darkTextPrimary #F5F5F5, darkTextSecondary #B8B8B8). Aucune couleur hardcodee.
  - `lib/src/app/design/themes/app_themes.dart` : `AppThemes.dark` etendu avec colorScheme.dark complet, scaffold, canvas, AppBar (greyDarkest conserve pour la coherence brand), card, divider, inputs (fill darkSurfaceVariant, border darkBorder, focus or-jaune), dialog, listTile, tooltip, snackbar, chip, textButton. `brightness: Brightness.dark` explicite.
  - `DESIGN_SYSTEM.md` : nouvelle section "Dark theme surfaces" documentant les 6 tokens.
- **Fichiers crees** :
  - `test/app/design/app_themes_test.dart` : 4 tests (light pumpe, dark pumpe, dark brightness + primary gold preserve, light/dark partagent meme primary).
- **Decisions design** :
  - L'AppBar dark conserve `greyDarkest` (#413E40, identique au light) pour garder une signature brand reconnaissable entre les deux modes.
  - Les icones en dark passent en `primaryLight` (gold clair) pour le contraste sur surface sombre.
  - Le focus border des inputs reste gold dans les deux modes — c'est l'element brand le plus visible.
- **Verification** : `flutter test` complet → 13/13 OK. `flutter analyze lib/src/app/design/` → 0 issues.

### 2026-05-19 - US-3.1.2 terminee
- **Action** : Implementation de US-3.1.2 (ThemeBloc + wiring MaterialApp) et suppression d'un fichier de test casse pre-existant.
- **Fichiers crees** :
  - `lib/src/app/theme/theme_bloc.dart` (Cubit<AppThemeMode>, miroir de LocaleBloc + `toggle()` helper)
  - `test/app/theme/theme_bloc_test.dart` (5 tests : etat initial sans cache, etat initial depuis cache, change emit + persistance, change no-op, toggle)
- **Fichiers modifies** :
  - `lib/src/app/binding/app_bindings.dart` (registration ThemePreferenceService + ThemeBloc)
  - `lib/src/app/app_widget.dart` (MultiBlocProvider, BlocBuilder<ThemeBloc>, `themeMode` switch entre `AppThemes.light` et `AppThemes.dark`)
- **Fichiers supprimes** :
  - `test/e2e_shift_handover_test.dart` — fichier vide (entierement commente avec une syntaxe cassee dans les commentaires). Bloquait `flutter test` global apres le bootstrap de l'infra. N'avait jamais fonctionne.
- **Verification** : `flutter test` complet (sans args) → 9/9 OK. `flutter analyze` sur les fichiers modifies → 0 issues.
- **Note technique** : `AppThemes.dark` est toujours partiel (sera finalise dans US-3.1.4). Pour l'instant, basculer en dark mode applique le theme par defaut Material dark heritage, ce qui suffit pour valider la mecanique de switch mais pas pour la qualite visuelle.

### 2026-05-19 - US-3.1.3 terminee + bootstrap infra de tests
- **Action** : Implementation de US-3.1.3 (ThemePreferenceService) et ajout de `flutter_test` aux dev_dependencies (premier test du projet).
- **Fichiers crees** :
  - `lib/src/app/theme/app_theme_mode.dart` (enum AppThemeMode { light, dark }, miroir d'AppLanguage)
  - `lib/src/core/services/theme_preference_service.dart` (miroir de LocalePreferenceService, cle `app_theme_mode`)
  - `test/core/services/theme_preference_service_test.dart` (4 tests, tous passent)
- **Fichiers modifies** : `pubspec.yaml` (ajout `flutter_test: sdk: flutter`)
- **Raison** : Le projet n'avait aucune infrastructure de test (`test/e2e_shift_handover_test.dart` etait entierement commente). Le skill `/workflow-start-implementation` prescrit TDD, et le tracker liste "Tests frontend" comme deliverable de la Feature 3.1. Decision utilisateur : bootstrapper l'infra de tests avec cette US plutot que de creer une feature separee.
- **Impact projet** : Tous les futurs Sets pourront ajouter des tests unitaires sans setup supplementaire. Le pattern `SharedPreferences.setMockInitialValues + CacheManagerImpl` est la reference pour tester les services bases sur le cache.
- **Verification** : `flutter test test/core/services/theme_preference_service_test.dart` → 4/4 OK. `flutter analyze` sur les nouveaux fichiers → 0 issues.

### 2026-05-19 - Creation Set 2 + ajout Feature 3.1
- **Action** : Creation d'un nouveau Set 2 "Polish & Personnalisation" et ajout de la Feature 3.1 Settings Theme Toggle
- **Module ajoute** : Settings (nouveau module dans `LISTE-DES-FONCTIONS.md`, le 3eme)
- **Feature 3.1** : Settings Theme Toggle (light/dark) - 4 US, 3 jours
- **Set** : Set 2 - nouveau Set (1/5 features), Set 1 reste plein (5/5)
- **Raison** : Demande utilisateur lors de l'exercice du guide VibeCoding (`docs/VIBECODING-GUIDE.md` section 8). Set 1 etait au cap, donc Set 2 cree.
- **Dette technique relevee** : Le dossier `lib/src/features/settings/` existe deja avec un toggle de langue fonctionnel, mais aucune feature Settings n'etait jusqu'ici dans le spec. La Feature 3.1 introduit le module Settings dans le tracker mais ne re-documente pas le toggle de langue existant (a faire dans un futur Set si necessaire de tracer historiquement).
- **Pre-requis technique** : `AppThemes.dark` existe en partiel dans `lib/src/app/design/themes/` - US-3.1.4 est dediee a sa finalisation.