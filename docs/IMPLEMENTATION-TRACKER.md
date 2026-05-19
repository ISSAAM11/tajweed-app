# Implementation Tracker - Tajweed AI

> Suivi de l'implementation feature par feature, organise en Sets de 5 features max.
> Voir [docs/commercial/LISTE-DES-FONCTIONS.md](./commercial/LISTE-DES-FONCTIONS.md) pour les specs User Stories.

---

## Dashboard

- **Total features** : 5
- **Total User Stories** : 20
- **Effort total** : 15 jours
- **Set actif** : Set 1
- **Progression globale** : 0% (0/5 features terminees)

### Status par Set

| Set | Objectif | Features | Status |
|-----|----------|----------|--------|
| Set 1 | Finalisation MVP - Auth & Home | 5/5 | En cours (cap atteint) |

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

## Backlog - Features Ajoutees

| Date | Feature | Module | Set | Effort | Source |
|------|---------|--------|-----|--------|--------|
| 2026-05-18 | 1.1 Sign In | Auth | Set 1 | 4.25j | Bootstrap initial |
| 2026-05-18 | 1.2 Sign Up | Auth | Set 1 | 4.25j | Bootstrap initial |
| 2026-05-18 | 1.3 Home Screen (Chooser) | Home | Set 1 | 1.5j | Refactor du 1.3 initial - demande utilisateur |
| 2026-05-18 | 1.4 Tajweed Courses Screen | Home | Set 1 | 3j | Bootstrap initial - demande utilisateur |
| 2026-05-18 | 1.5 Quran Listing | Home | Set 1 | 2j | Extrait de l'ancien 1.3 - n'est plus la home |

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