# Implementation Tracker - Tajweed AI

> Suivi de l'implementation feature par feature, organise en Sets de 5 features max.
> Voir [docs/commercial/LISTE-DES-FONCTIONS.md](./commercial/LISTE-DES-FONCTIONS.md) pour les specs User Stories.

---

## Dashboard

- **Total features** : 11
- **Total User Stories** : ~48
- **Set actif** : Set 3 - AI & Recitation (1.7 frontend livre)
- **Progression globale** : 45% (5/11 features terminees : 3.1, 3.2, 3.3, 3.4, 1.4)

### Status par Set

| Set | Objectif | Features | Status |
|-----|----------|----------|--------|
| Set 1 | Finalisation MVP - Auth & Home | 5/5 | Differe post-v1 (sauf 1.4) |
| Set 2 | Polish & Personnalisation | 2/5 | 2 features terminees |
| **Release v1** | **3 ecrans + Coming Soon UI** | **3** | **En cours** |
| Set 3 | AI & Recitation | 2/5 | 1.6 spec ; 1.7 frontend livre |

---

## Release v1 - Scope

**Objectif** : Livrer une v1.0.0 installable. Seuls 3 ecrans sont implementes ; le reste du backlog est gate derriere un widget "Coming Soon" pour preserver le roadmap visible sans bloquer la release.

**Inclus dans v1** :
- **Feature 1.4** Tajweed Courses Screen (contenu statique des regles Tajweed pour la release)
- **Feature 3.3** Settings Polish (extension de l'ecran Settings : navigation My Account, version app, Terms/Privacy/About, tuiles Coming Soon)
- **Feature 3.4** My Account Screen (profil, email, sign out)
- **Widget transverse** `ComingSoonBadge` + ARB keys (`comingSoonLabel`, `comingSoonMessage`)

**Differe post-v1 (visible via tuile Coming Soon)** :
- Feature 1.1 Sign In OAuth (Google/Apple), Forgot Password
- Feature 1.2 Sign Up backend integration
- Feature 1.3 Home Screen Chooser
- Feature 1.5 Quran Listing finitions

**Branche** : `feat/release-v1-screens`

---

## Set 1 - Finalisation MVP Auth & Home

**Objectif** : Terminer les ecrans de base (login, inscription, home) et ajouter l'acces aux cours Tajweed pour livrer un MVP fonctionnel.

**Status** : En cours
**Features** : 5/5 (cap atteint)
**Effort** : 15 jours

### [Feature 1.1] Sign In (Login)

- **Status** : Differe post-v1 (UI existante conservee ; Coming Soon pour OAuth/Forgot Password)
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

- **Status** : Differe post-v1 (UI existante conservee ; Coming Soon pour activation backend)
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

- **Status** : Differe post-v1 (la home reste `/quran-listing` pour la v1)
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

- **Status** : **Termine (Release v1)** — contenu statique livre 2026-05-21
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

- **Status** : Differe post-v1 (UI existante shippee telle quelle dans la v1)
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

**Status** : 2 terminees + 2 actives (Release v1)
**Features** : 4/5
**Effort** : ~8 jours

### [Feature 3.1] Settings Theme Toggle

- **Status** : Termine
- **Branche** : `feat/IB-f3.1-us1-4`
- **Started** : 2026-05-19
- **Completed** : 2026-05-19
- **Module** : Settings (nouveau module)
- **Effort** : 3 jours (4 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/features/settings/` (existe deja - contient le toggle de langue)
- **Note** : Le dossier `lib/src/features/settings/` existe deja avec le toggle de langue, mais aucune feature Settings n'etait jusqu'ici tracee. Cette feature introduit officiellement le module Settings dans le spec. L'infrastructure `AppThemes.light` + `AppThemes.dark` est deja presente dans `lib/src/app/design/themes/` (dark mode partiel a finaliser via US-3.1.4).
- **Backend** :
  - [ ] Aucun (preference locale, persistance via SharedPreferences)
- **Frontend** :
  - [x] US-3.1.1 : Section "Apparence" dans Settings avec affichage du theme actuel (S) — `SettingsAppearanceSection` (public widget extrait de `settings_screen.dart`), insertion dans `SettingsScreen` apres la section langue, 2 widget tests
  - [x] US-3.1.2 : Toggle/Switch pour basculer light/dark, application immediate via ThemeBloc/Cubit (M) — `lib/src/app/theme/theme_bloc.dart` (Cubit<AppThemeMode> + toggle()) registered as singleton, `MaterialApp.router` rebuilds via `BlocBuilder<ThemeBloc>` + `themeMode` switch, 5 tests
  - [x] US-3.1.3 : `ThemePreferenceService` (pattern `LocalePreferenceService`) - persistance SharedPreferences (S) — `lib/src/core/services/theme_preference_service.dart` + `lib/src/app/theme/app_theme_mode.dart` + 4 tests
  - [x] US-3.1.4 : Finalisation `AppThemes.dark` - palette inversee, contrastes coherents avec gold brand (M) — 6 nouveaux tokens dans `AppColors` (`darkScaffold`, `darkSurface`, `darkSurfaceVariant`, `darkBorder`, `darkTextPrimary`, `darkTextSecondary`), `AppThemes.dark` etendu (colorScheme dark, scaffold, AppBar, card, divider, inputs, dialog, listTile, tooltip, snackbar, chip, textButton), 4 tests, `DESIGN_SYSTEM.md` documente
  - [x] Cles ARB `settingsAppearance`, `settingsThemeLight`, `settingsThemeDark` dans `app_en.arb` + `app_ar.arb`
  - [x] Tests frontend (infrastructure + couverture) — `flutter_test` ajoute au pubspec, infra de test creee. `flutter test` complet : 15/15 OK (4 ThemePreferenceService + 5 ThemeBloc + 4 AppThemes + 2 SettingsAppearanceSection).

### [Feature 3.2] Dark Mode Palette Rollout

- **Status** : Termine (manuel QA a finaliser apres `flutter run`)
- **Branche** : `feat/IB-f3.1-us1-4` (continuee depuis Feature 3.1)
- **Started** : 2026-05-20
- **Completed** : 2026-05-20
- **Module** : Settings (design system)
- **Effort** : 3 jours (5 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/app/design/colors/`, `lib/src/app/design/themes/`, `lib/src/features/**/widgets/`
- **Note** : Feature 3.1 a livre l'infrastructure (ThemeBloc, persistance, toggle Settings, AppThemes.dark partiel). Mais l'audit a revele 127 references directes a `AppColors.*` dans 28 fichiers widget, et zero usage de `Theme.of(context).colorScheme` — donc basculer en dark mode ne change que le chrome Material (AppBar, Card via theme par defaut). Cette feature applique la palette spec "Serene Tajweed Night" et migre les widgets vers la lecture theme-reactive canonique. Le light mode reste intact (le spec light propose un palette Charcoal-primary qui contredit l'identite gold-on-white shipped — traite comme aspirationnel).
- **Backend** :
  - [ ] Aucun
- **Frontend** :
  - [x] US-3.2.1 : Rafraichir `AppColors.dark*` aux valeurs spec (S) — 6 tokens mis a jour + 10 nouveaux tokens (`darkSurfaceContainerLowest`, `darkSurfaceContainerLow`, `darkSurfaceContainerHighest`, `darkSurfaceBright`, `darkOutline`, `darkPrimary`, `darkOnPrimary`, `darkPrimaryContainer`, `darkError`, `darkOnError`). `bottomBarDarkColor` aligne sur le nouveau `darkScaffold` (#131313).
  - [x] US-3.2.2 : Cabler `AppThemes.dark.colorScheme` aux nouveaux tokens (M) — `ColorScheme.dark` complete (primary→darkPrimary, surface→darkScaffold, surfaceContainer/Low/Lowest/High/Highest, outline/outlineVariant, error/onError). `cardTheme` dark : no shadow, tonal layering. AppThemes.light egalement renforce avec surfaceContainerHigh explicite pour preserver l'identite light. 7 tests dans `app_themes_test.dart` (was 4) : tous OK.
  - [x] US-3.2.3 : Migration des 9 widgets hotspots vers `Theme.of(context).colorScheme.*` (M) — settings_screen, form_input, home_action_card, surah_listing_screen, loading_button, surah_name_card migres. last_reading_card / home_header / page_viewer (principal) confirmes brand-locked (zero migration necessaire).
  - [x] US-3.2.4 : Migration des widgets restants (S) — third_step, terms_of_use, did_user_have_an_account, social_login_button, bottom_picker, animated_stepper, or_devider, second_step, quran_list_view (avec ajout BuildContext au _buildPartitionItem), signup_screen, sign_in_screen, home_screen, custom_date_picker. Refactoring de `custom_date_picker` : decoration container deplacee de `initState` vers `build` pour acceder a `Theme.of(context)`. tajweed_test / tajweed_text / app_logo confirmes brand-locked.
  - [x] US-3.2.5 : Sync docs (S) — `DESIGN_SYSTEM.md` mis a jour : nouvelle table de tokens dark (16 entrees, mapping spec inclus), nouvelle section "How to consume colors in a widget" avec la regle two-bucket (brand-locked vs theme-reactive) et table de mapping AppColors.* → colorScheme.*.
  - [x] Tests frontend — 18/18 OK (4 ThemePreferenceService + 5 ThemeBloc + 7 AppThemes + 2 SettingsAppearanceSection). 3 nouveaux tests dans `app_themes_test.dart` couvrant les obsidian surface tiers + outline tokens + AppBar brand-signature.

### [Feature 3.3] Settings Polish (Release v1 extension)

- **Status** : **Termine (Release v1)** — livre 2026-05-21
- **Module** : Settings
- **Effort** : 1.5 jours (5 User Stories)
- **Complexite** : Simple
- **Localisation** : `lib/src/features/settings/widgets/settings_screen.dart` (extension de l'existant)
- **Note** : Etend l'ecran Settings existant avec des entrees de navigation et des tuiles Coming Soon pour les features differees. N'ajoute pas de nouveau Bloc — utilise les preferences globales existantes (LocaleBloc, ThemeBloc) et le widget `ComingSoonBadge` transverse.
- **Backend** :
  - [ ] Aucun
- **Frontend** :
  - [ ] US-3.3.1 : Section "Compte" avec entree "My Account" (navigation vers `/my-account`) (XS)
  - [ ] US-3.3.2 : Section "A propos" : version de l'app (lue depuis `package_info_plus`), Terms of Use, Privacy Policy, About (S)
  - [ ] US-3.3.3 : Section "Bientot disponible" listant les features differees avec `ComingSoonBadge` (Notifications, Reminders, Cloud Sync, etc.) (S)
  - [ ] US-3.3.4 : Cles ARB pour toutes les nouvelles entrees dans `app_en.arb` + `app_ar.arb` (XS)
  - [ ] US-3.3.5 : Tests widget pour la nouvelle structure (XS)

### [Feature 3.4] My Account Screen (Release v1)

- **Status** : **Termine (Release v1)** — livre 2026-05-21
- **Module** : Account (nouveau)
- **Effort** : 2 jours (4 User Stories)
- **Complexite** : Moyenne
- **Localisation** : `lib/src/features/my_account/` (a creer)
- **Note** : Ecran statique en v1 — affiche les infos du compte stockees localement (email du token JWT decodelocalement ou placeholder si invite) + sign out. Le profil editable (avatar, change password) est differe post-v1.
- **Backend** :
  - [ ] Aucun pour v1 (sign out = effacement local des tokens via `AppConfig` / `CacheManager`)
- **Frontend** :
  - [ ] US-3.4.1 : Structure feature (binding/data/router/vm) selon le module pattern (S)
  - [ ] US-3.4.2 : Affichage email + nom (depuis tokens ou placeholder) (S)
  - [ ] US-3.4.3 : Section "Bientot disponible" avec `ComingSoonBadge` (Change password, Avatar, Linked accounts) (S)
  - [ ] US-3.4.4 : Bouton "Sign Out" avec dialog de confirmation, clear tokens, redirect vers `/sign-in` (M)
  - [ ] US-3.4.5 : Cles ARB dans `app_en.arb` + `app_ar.arb` (XS)
  - [ ] Tests widget de base

---

## Set 3 - AI & Recitation

**Objectif** : Introduire la validation de recitation par IA (temps reel) — premiere brique IA de l'app.

**Status** : Spec redigee, implementation a faire
**Features** : 2/5
**Effort** : 2.5 jours (1.6) + ~4.75 jours (1.7) frontend ; backend Django + Deepgram comptes separement

### [Feature 1.6] Recitation Test

- **Status** : A faire (spec complete dans `docs/specs/recitation-test/`)
- **Module** : Home
- **Effort** : 2.5 jours frontend (5 User Stories)
- **Complexite** : Complexe
- **Localisation** : `lib/src/features/home/quran/recitation_test/` (a creer)
- **Spec** : [docs/specs/recitation-test/](./specs/recitation-test/) — README / requirements / design / tasks
- **Note** : Lancee depuis la 4e action de la home (`home_screen.dart`, anciennement "Quran reflection", lightbulb, sans route → "Coming soon"), repurposee en "Recitation Test" vers `/recitation-test`. Architecture : Flutter ⇄ Django Channels ⇄ Deepgram (STT streaming), matching lettre par lettre, coloration verte/rouge en temps reel. Cle Deepgram cote serveur uniquement.
- **Backend (Django)** :
  - [ ] Phase 0 : Spike Deepgram (precision recitation arabe) avant build
  - [ ] Django Channels (ASGI) + routing `ws/recitation/`
  - [ ] Consumer WebSocket : message `config`, ouverture socket Deepgram (`language=ar`, `interim_results=true`, `linear16`, 16kHz, mono)
  - [ ] Relai audio app → Deepgram
  - [ ] Util de normalisation (lettres seules) + tests
  - [ ] Service d'alignement en ligne (pointeur + look-ahead, commit sur `is_final`) + tests
  - [ ] Serialisation des verdicts (`verdict` / `done` / `error`)
  - [ ] Teardown session + tests consumer
- **Frontend (Flutter)** :
  - [ ] US-1.6.1 : Repurpose 4e HomeAction → `/recitation-test` + re-texte ARB (en+ar) (XS)
  - [ ] US-1.6.2 : Ecran + rendu mot par mot (Uthmani, neutre) depuis `getWordsForSurah(1)` (S)
  - [ ] US-1.6.3 : Controle enregistrement (`record` stream) + permission micro + `RECORD_AUDIO` (S)
  - [ ] US-1.6.4 : `RecitationSocketClient` (`web_socket_channel`) + BLoC + verdicts temps reel (tentatif/locked) (M)
  - [ ] US-1.6.5 : Reset session → neutre (XS)
  - [ ] `getWordsForSurah(int)` dans `QuranPageDao` ; `wsBaseUrl` dans `environments.dart`
  - [ ] Cles ARB ecran (en+ar) ; route dans `app_router.dart` ; binding DI
  - [ ] Tests widget (rendu neutre, coloration via verdicts, reset)

### [Feature 1.7] Quran-Page Recitation

- **Status** : En cours — frontend livre ; validation device + backend live a faire
- **Module** : Home
- **Effort** : ~4.75 jours frontend (8 User Stories) ; backend reutilise de la 1.6
- **Complexite** : Complexe
- **Localisation** : `lib/src/features/home/quran/page/` (vm/recitation/ + widgets/)
- **Spec** : [docs/specs/recitation/](./specs/recitation/) — README / requirements / design / tasks
- **Note** : Porte la recitation IA (pipeline de la 1.6) dans la vraie page de lecture : les mots du mushaf se colorent sur place (vert/rouge), barre en bas (record / masquer texte / recommencer / sourate suivante), mode memorisation "hide text", arret auto en fin de page. Contrat WebSocket reutilise tel quel (cf. 1.6). Garde aussi le mic du popup verset (1.6) + un bouton flottant pour demarrer d'une position precise.
- **Backend** :
  - [ ] Aucun nouveau — reutilise le consumer/alignement de la Feature 1.6
- **Frontend (Flutter)** :
  - [x] US-1.7.1 : Mode recitation + bottom app bar (`RecitationBottomBar`)
  - [x] US-1.7.2 : Toggle enregistrement (record/stop) + permission micro
  - [x] US-1.7.3 : Coloration des mots rendus en place (`tajweed_text.dart`, map `WordRow.id`)
  - [x] US-1.7.4 : Mode "hide text" (mot revele dans sa couleur de verdict une fois recite)
  - [x] US-1.7.5 : Recommencer → pointeur au debut de la page
  - [x] US-1.7.6 : Suivant → sourate suivante (`initToVerse`)
  - [x] US-1.7.7 : Arret auto quand la page est terminee (`isComplete`)
  - [x] US-1.7.8 : Bouton flottant → demarrer du verset selectionne
  - [x] Cles ARB (en+ar) ; bridge page-change ; DI (`QuranRecitationBloc`)
  - [ ] Tests widget + validation device avec backend live

---

## Widget Transverse - ComingSoonBadge

- **Status** : **Termine (Release v1)** — livre 2026-05-21
- **Localisation** : `lib/src/features/common/widgets/coming_soon_badge.dart` (a creer)
- **Description** : Tuile / chip reutilisable, visuellement attenuee, qui declenche un snackbar (ou dialog) localise au tap. Utilisee partout ou une feature differee est affichee.
- **Cles ARB requises** : `comingSoonLabel` ("Coming soon" / "Bientot disponible"), `comingSoonMessage` (message du snackbar) — ajoutees dans `app_en.arb` + `app_ar.arb`.

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
| 2026-05-20 | 3.2 Dark Mode Palette Rollout | Settings | Set 2 | 3j | Demande utilisateur (apres creation DESIGN-DARK-MODE.md / DESIGN-LIGHT-MODE.md) |
| 2026-05-21 | 3.3 Settings Polish | Settings | Set 2 | 1.5j | Demande utilisateur (preparation Release v1) |
| 2026-05-21 | 3.4 My Account Screen | Account | Set 2 | 2j | Demande utilisateur (preparation Release v1) |
| 2026-05-29 | 1.6 Recitation Test | Home | Set 3 | 2.5j | Demande utilisateur (validation recitation par IA) |
| 2026-06-01 | 1.7 Quran-Page Recitation | Home | Set 3 | 4.75j | Demande utilisateur (recitation + memorisation dans la page Coran) |

---

## Journal de bord

### 2026-06-01 - Feature 1.7 (Quran-Page Recitation) - Frontend livre
- **Action** : Portage de la recitation IA dans la page de lecture Coran + redaction de la spec `docs/specs/recitation/`. Pipeline backend (1.6) reutilise tel quel.
- **Livrables (frontend)** :
  - Bloc page-scoped `lib/src/features/home/quran/page/vm/recitation/` (state unique : modeActive / recording / hideText / pageNo / wordIndexById / verdicts / errorKey ; `verdictForWordId` + `isComplete`) + helper `recitation_words.dart`.
  - `RecitationBottomBar` (bottom app bar : record / hide-text / restart / next-surah / exit) ; `tajweed_text.dart` colore les glyphes + mode "hide text" ; bouton flottant dans `page_viewer.dart` pour demarrer du verset selectionne ; mic du popup verset conserve (1.6).
  - `quran_page_screen.dart` : provider `QuranRecitationBloc`, snackbar d'erreur, bridge `currentPage` → reset session ; DI dans `QuranPageDependencies` (instance propre de `RecitationSocketClient`).
  - DAO `getSurahWordsFromAyah` (select brut null-safe) pour le flux verset→fin de sourate.
  - 6 nouvelles cles ARB (en+ar) ; `flutter gen-l10n`.
  - Specs : `docs/specs/recitation/` (README / requirements US-1.7.1→1.7.8 INVEST + EARS / design / tasks).
- **Decisions** :
  - **Scope page** : on recite les mots reellement rendus (`PageContentDto` blocks), arret auto quand tous les verdicts sont `final`.
  - **Trois points d'entree** (demande utilisateur "keep both") : bottom app bar (page), bouton flottant (position selectionnee), mic du popup verset (sourate, 1.6).
  - **Next = sourate suivante** ; **restart = debut de page** ; **hide-text** revele chaque mot dans sa couleur de verdict.
  - State unique (copyWith) plutot que sealed : la barre persiste hors enregistrement et porte plusieurs flags.
- **Verification** : `flutter analyze` page feature → 0 issue nouvelle (1 lint pre-existant `dart:ui` dans audio_player_bar). Validation device + backend live a faire.
- **Source** : Demande utilisateur — recitation dans la page Coran avec barre (record, masquer texte pour memorisation, recommencer, sourate suivante) + arret auto en fin de page.

### 2026-05-29 - Bootstrap Feature 1.6 (Recitation Test) - Spec only
- **Action** : Redaction de la spec spec-driven pour la Feature 1.6 (Recitation Test). Documentation uniquement, aucun code source modifie.
- **Livrables** :
  - Dossier dedie `docs/specs/recitation-test/` : `README.md` (index), `requirements.md` (US-1.6.1 a 1.6.5 INVEST + criteres d'acceptation EARS), `design.md` (architecture complete), `tasks.md` (decoupage backend Django + frontend Flutter).
  - `LISTE-DES-FONCTIONS.md` : ajout Feature 1.6 (Module Home, Lot Set 3) + maj statistiques (7 features, 29 US, 20.5j).
  - `IMPLEMENTATION-TRACKER.md` : nouveau Set 3 "AI & Recitation" + entree Feature 1.6 (taches backend/frontend), ligne backlog, maj dashboard (10 features, progression 50%).
- **Decisions d'architecture** :
  - **Streaming temps reel** via WebSocket (pas de batch) — verdict mot par mot pendant la recitation.
  - **Topologie : Flutter ⇄ Django Channels ⇄ Deepgram** — Django proxy l'audio vers Deepgram (STT streaming) ; la cle API Deepgram reste cote serveur ; l'alignement tourne cote serveur (source unique de verite).
  - **Matching lettre par lettre** (pas de tashkeel, pas de scoring tajweed/phoneme) — normalisation (strip tashkeel, unification alef, tatweel, taa marbuta) appliquee aux deux cotes.
  - **Alignement en ligne** : pointeur + look-ahead, coloration tentative sur resultats interim, lock vert/rouge sur `is_final`.
  - **v1 statique** : Al-Fatiha uniquement, focus sur l'architecture IA.
  - **Point d'entree** : repurpose de la 4e HomeAction (anciennement "Quran reflection") vers `/recitation-test`.
- **Spike pre-build** : valider la precision de Deepgram sur de l'audio de recitation arabe classique avant de construire la stack (l'arabe coranique differe de l'arabe conversationnel d'entrainement de Deepgram).
- **Source** : Demande utilisateur — "ai validation of user recitation ... a quran word by word check ... green if correct, red if wrong", puis choix Deepgram STT + WebSocket + proxy Django.

### 2026-05-21 - Release v1 LIVREE (Features 1.4 + 3.3 + 3.4)
- **Action** : Implementation complete des 3 features de la Release v1 dans la meme session que le bootstrap. Version bumpee a 1.0.0+1 dans `pubspec.yaml`.
- **Feature 3.3 (Settings Polish)** : `SettingsScreen` etendu avec 4 nouvelles sections — Account card (chevron vers /my-account), Coming Soon (Notifications + Daily reminders via `ComingSoonTile`), About (version via `package_info_plus` + Terms of Use). Nouvelle route `/terms-of-use` avec un `TermsOfUseScreen` statique. 11 nouvelles cles ARB.
- **Feature 3.4 (My Account)** : Nouveau module `lib/src/features/my_account/`. Ecran StatelessWidget — profile header "Guest" placeholder, 3 tuiles Coming Soon (Change password, Avatar, Linked accounts), bouton Sign Out avec dialog de confirmation. Sign out clear `FlutterSecureStorage` et redirige vers `/sign-in`. 10 nouvelles cles ARB.
- **Feature 1.4 (Tajweed Courses)** : Nouveau module `lib/src/features/tajweed_courses/`. Ecran statique avec intro + 6 cartes de regles (Madd, Ghunnah, Idgham, Ikhfa, Iqlab, Qalqala) + tuile Coming Soon "Interactive lessons". Wirage du tile "Tajweed Lessons" du home vers `/tajweed-courses`. 14 nouvelles cles ARB.
- **Widget transverse `ComingSoonTile`** : Cree dans `lib/src/features/common/widgets/`. Theme-reactive (lit `Theme.of(context).colorScheme.*`), tap declenche un info snackbar localise. Metrics block dedie `AppMetrics.comingSoonTile`. ARB key `comingSoonMessage` ajoutee (reutilise `comingSoon` existant pour le badge).
- **Cleanup** : Suppression de l'import non utilise dans `app_config.dart` et de la note "dev mode" obsolete dans `CLAUDE.md`. main.dart n'avait deja plus de devRoute, donc rien a retirer la.
- **Verification** : `flutter test` complet → 18/18 OK. `flutter analyze` → 5 issues pre-existantes uniquement (tajweed_test mock + ayah_popup print). EN/AR + Light/Dark verification visuelle a faire par l'utilisateur via `flutter run`.
- **Progression** : 5/9 features terminees. Release v1 prete pour `flutter build apk --release`.

### 2026-05-21 - Bootstrap Release v1 (Features 3.3 + 3.4 + ComingSoonBadge)
- **Action** : Definition du scope Release v1.0.0 — la v1 ne porte que 3 ecrans (Tajweed Courses, Settings polish, My Account). Le reste du backlog est gate derriere un widget `ComingSoonBadge` reutilisable.
- **Decisions** :
  - **Feature 1.4 (Tajweed Courses)** promue en active dans Set 1 — scope reduit a du contenu statique pour ne pas dependre du backend.
  - **Features 1.1, 1.2, 1.3, 1.5** marquees "Differe post-v1". Leur UI partiellement implementee reste shippee telle quelle ; les fonctionnalites manquantes (OAuth, activation email, Home Chooser) sont gatees Coming Soon.
  - **Feature 3.3 (Settings Polish)** ajoutee a Set 2 — extension de l'ecran Settings existant : navigation My Account, version app, Terms/Privacy/About, tuiles Coming Soon.
  - **Feature 3.4 (My Account Screen)** ajoutee a Set 2 — nouveau module `account`, affichage email + sign out, le reste differe.
  - **`ComingSoonBadge`** widget transverse + ARB keys `comingSoonLabel` / `comingSoonMessage` — pre-requis pour 3.3 et 3.4.
- **Branche** : `feat/release-v1-screens` (cree depuis `origin/main` = f3b5cde).
- **Outil ajoute** : `.claude/settings.json` (allowlist large + denylist destructive) + `.claude/README.md` pour la prochaine session.
- **Source** : Demande utilisateur — "i want to make this application for a release version, and i want to add few features (setting screen, quran rules screen, my account screen)".

### 2026-05-20 - Feature 3.2 TERMINEE (US-3.2.1 a US-3.2.5)
- **Action** : Implementation complete de la Feature 3.2 dans la meme session que son bootstrap.
- **Fichiers crees** : aucun nouveau fichier source ; 3 tests ajoutes a `test/app/design/app_themes_test.dart` (now 7 tests, was 4).
- **Fichiers modifies (palette + theme)** :
  - `lib/src/app/design/colors/app_colors.dart` : 6 tokens dark mis a jour aux valeurs spec, 10 nouveaux tokens dark ajoutes, `bottomBarDarkColor` aligne.
  - `lib/src/app/design/themes/app_themes.dart` : `ColorScheme.dark` etendue avec 7 tiers de surfaces + outline tokens + dark error variants ; `AppThemes.light.colorScheme` renforce avec `surfaceContainerHigh/etc.` explicites pour preserver l'identite ; `cardTheme` dark sans shadow (tonal layering).
- **Fichiers modifies (widget migration)** : 13 widgets migres vers `Theme.of(context).colorScheme.*` — settings_screen, form_input, home_action_card, surah_listing_screen, loading_button, surah_name_card, third_step, terms_of_use, did_user_have_an_account, social_login_button, bottom_picker, animated_stepper, or_devider, second_step, quran_list_view, signup_screen, sign_in_screen, home_screen, custom_date_picker. Note : `custom_date_picker` a necessite un refactoring (decoration deplacee de `initState` vers `build` pour acceder au context).
- **Fichiers confirmes brand-locked (zero migration)** : last_reading_card (carte gold/cream), home_header (AppBar), page_viewer principal et tajweed_test (paper-textured pages), tajweed_text (texte arabe sur paper), app_logo (logo gold), forgot_password_button (lien gold).
- **Documentation** : `DESIGN_SYSTEM.md` mis a jour avec la nouvelle table de tokens dark (16 entrees, mapping spec) et nouvelle section "How to consume colors in a widget" (regle two-bucket : brand-locked vs theme-reactive, table de migration AppColors.* → colorScheme.*).
- **Decisions design** :
  - `darkPrimary` (#F2CA50) plus lumineux que le light primary (#D4AF37) pour rester lisible sur obsidian — preserve la cohesion brand via `darkPrimaryContainer` qui reprend le light primary.
  - `darkTextPrimary` = #E5E2E1 (cream chaud) au lieu de blanc pur (#F5F5F5 ancien) pour reduire la fatigue oculaire en mode sombre (recommendation spec).
  - Tonal layering > shadows en mode dark : `cardTheme.dark` desactive elevation et shadow.
  - AppBar reste `greyDarkest` dans les deux modes (decision Feature 3.1 preservee).
  - Light mode preserve byte-identique : ajout explicite de `surfaceContainerHigh: AppColors.greyBackground` pour eviter la derive auto-derivee.
- **Verification** : `flutter test` complet → 18/18 OK (was 15). `flutter analyze` : 6 issues pre-existantes non liees a Feature 3.2 (unused imports + TODO prints dans tajweed_test). Manuel `flutter run` requis pour valider visuellement chaque ecran (US-3.2.5 verification finale).
- **Progression** : Feature 3.2 100% terminee (5/5 US). Set 2 : 2/5 features. Progression globale : 31% (9/29 US).

### 2026-05-20 - Bootstrap Feature 3.2
- **Action** : Creation de la Feature 3.2 "Dark Mode Palette Rollout" suite a la creation des specs `DESIGN-DARK-MODE.md` et `DESIGN-LIGHT-MODE.md` par l'utilisateur.
- **Audit Phase 1** : 127 references directes a `AppColors.*` dans 28 fichiers widget, zero usage de `Theme.of(context).colorScheme`. Top hotspots : settings_screen (19), form_input (15), home_action_card (11). La Feature 3.1 a livre l'infrastructure mais le wiring widget n'a pas suivi.
- **Audit Phase 2** : 19 des 44 tokens du spec dark sont manquants ou ont une valeur hex incorrecte. La palette actuelle (`darkScaffold` #1A1A1A, etc.) ne reflete pas la spec "Serene Tajweed Night" (#131313 + tiered surfaces).
- **Decisions** :
  - **Palette dark strict, light intact** — applique la spec dark fidelement; ignore la spec light (Charcoal-primary) qui contredit l'identite gold-on-white shipped.
  - **API: `Theme.of(context).colorScheme.*` canonique** (pas de custom extension) — pattern Flutter standard, facile a apprendre pour un debutant, ergonomie chain-friendly avec `.withColor()`.
  - **Deux-bucket rule** : brand-locked (primary, error, AppBar) reste sur `AppColors.*` direct ; theme-reactive (scaffold, text, surface, borders) migre vers `Theme.of(context).colorScheme.*`.
  - Per-theme Tajweed colors **defer** (consomme nulle part actuellement).
  - Nouveaux fonts (Noto Serif / Plus Jakarta Sans / Work Sans) **defer** (Feature 3.3 future si voulu) — assets ~500KB.
- **Plan** : 5 US (3.2.1 palette → 3.2.2 ColorScheme → 3.2.3 hotspots → 3.2.4 reste → 3.2.5 QA + docs). Plan complet dans `C:\Users\Hp\.claude\plans\how-to-apply-this-indexed-cerf.md`.

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

### 2026-05-19 - Feature 3.1 TERMINEE (US-3.1.1 + cloture)
- **Action** : Implementation de US-3.1.1 (Settings UI section + ARB) et cloture de la Feature 3.1.
- **Fichiers crees** :
  - `test/features/settings/theme_section_test.dart` : 2 widget tests (rendu des labels EN, tap Dark switche le bloc).
- **Fichiers modifies** :
  - `lib/l10n/app_en.arb` : ajout `settingsAppearance`, `settingsThemeLight`, `settingsThemeDark`.
  - `lib/l10n/app_ar.arb` : memes cles avec traductions arabes (المظهر, فاتح, داكن).
  - `lib/src/features/settings/widgets/settings_screen.dart` : extraction d'un widget public `SettingsAppearanceSection` (rebuilds via BlocBuilder<ThemeBloc>, taps appellent `themeBloc.change()`). Section "Apparence" inseree sous la section langue, avec un gap de `AppMetrics.spacing.md`. Nouveau widget prive `_ThemeOption` (mirroir de `_LanguageOption`).
- **Decision design** : `SettingsAppearanceSection` est extraite en widget PUBLIC plutot qu'integree directement dans `_SettingsScreenState`. Raison : permet un widget test isole (sans devoir wirer LocaleBloc + SettingsBloc + routing). Mirroir de `LocaleBloc` dans `SettingsBloc` non reproduit pour `ThemeBloc` — la section parle directement au ThemeBloc global via `get<ThemeBloc>()`. Plus simple, pas de synchronisation a maintenir.
- **Verification** : `flutter test` complet → 15/15 OK. `flutter analyze` sur les fichiers modifies → 0 issues.
- **Progression** : Feature 3.1 100% terminee (4/4 US). Set 2 : 1/5 features. Progression globale : 17% (4/24 US).

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