# Liste des Fonctions - Tajweed AI

> Document commercial decrivant les modules fonctionnels et leurs User Stories.
> Format : INVEST (Independent, Negotiable, Valuable, Estimable, Small, Testable).
> Tailles : XS (0.25j), S (0.5j), M (1j), L (2j), XL (3j).

---

## Statistiques

- **Modules** : 3 (Auth, Home, Settings)
- **Features** : 8
- **User Stories** : 37
- **Effort total** : 25.25 jours

---

## Module 1 : Auth

Gestion de l'authentification utilisateur (connexion, inscription, mode invite).

### Feature 1.1 - Sign In (Login)

- **Complexite** : Moyenne
- **Description** : Ecran de connexion permettant a l'utilisateur de s'authentifier via email/password, login social, ou en mode invite.
- **Lot** : Set 1

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.1.1 | En tant qu'utilisateur, je veux saisir mon email et mon mot de passe pour me connecter afin d'acceder a mon compte | M | 1 |
| US-1.1.2 | En tant qu'utilisateur, je veux voir un message clair en cas d'erreur de connexion afin de comprendre ce qui ne va pas | S | 0.5 |
| US-1.1.3 | En tant qu'utilisateur, je veux continuer en mode invite afin d'essayer l'app sans creer de compte | XS | 0.25 |
| US-1.1.4 | En tant qu'utilisateur, je veux pouvoir reinitialiser mon mot de passe oublie afin de recuperer l'acces a mon compte | S | 0.5 |
| US-1.1.5 | En tant qu'utilisateur, je veux me connecter avec Google ou Apple afin d'eviter de creer un mot de passe | L | 2 |

- **Effort total** : 4.25 jours
- **Dependances** : Aucune

### Feature 1.2 - Sign Up

- **Complexite** : Complexe
- **Description** : Ecran d'inscription multi-etapes (informations personnelles, profil, activation) avec validation.
- **Lot** : Set 1

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.2.1 | En tant qu'utilisateur, je veux suivre un formulaire d'inscription en plusieurs etapes afin de ne pas etre submerge par les champs | L | 2 |
| US-1.2.2 | En tant qu'utilisateur, je veux que mes saisies (email, date, pays) soient validees afin d'eviter les erreurs | M | 1 |
| US-1.2.3 | En tant qu'utilisateur, je veux activer mon compte via un code recu afin de confirmer mon identite | M | 1 |
| US-1.2.4 | En tant qu'utilisateur, je veux accepter les conditions d'utilisation afin de finaliser mon inscription | XS | 0.25 |

- **Effort total** : 4.25 jours
- **Dependances** : Feature 1.1 (Sign In - point d'entree commun)

---

## Module 2 : Home

Page d'accueil et navigation vers les sections principales.

### Feature 1.3 - Home Screen (Chooser)

- **Complexite** : Simple
- **Description** : Ecran d'accueil minimaliste qui permet a l'utilisateur de choisir entre deux parcours principaux : la lecture du Coran (Quran Listing) ou les cours Tajweed.
- **Lot** : Set 1

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.3.1 | En tant qu'utilisateur, je veux voir un ecran d'accueil avec deux options claires (Coran / Cours Tajweed) afin de choisir mon parcours | S | 0.5 |
| US-1.3.2 | En tant qu'utilisateur, je veux taper sur "Coran" pour ouvrir la liste des sourates afin de commencer a lire | XS | 0.25 |
| US-1.3.3 | En tant qu'utilisateur, je veux taper sur "Cours Tajweed" pour ouvrir l'ecran des cours afin d'apprendre les regles de recitation | XS | 0.25 |
| US-1.3.4 | En tant qu'utilisateur, je veux un header avec un accueil personnalise (nom / salutation) afin de me sentir engage | S | 0.5 |

- **Effort total** : 1.5 jours
- **Dependances** : Feature 1.5 (Quran Listing - cible de navigation), Feature 1.4 (Tajweed Courses - cible de navigation)

### Feature 1.4 - Tajweed Courses Screen

- **Complexite** : Moyenne
- **Description** : NOUVEAU - Ecran listant les cours Tajweed disponibles, accessible depuis la home. Chaque cours affiche titre, description, et progression utilisateur.
- **Lot** : Set 1

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.4.1 | En tant qu'utilisateur, je veux voir la liste des cours Tajweed disponibles afin de choisir lequel commencer | M | 1 |
| US-1.4.2 | En tant qu'utilisateur, je veux voir le titre, la description et ma progression sur chaque cours afin de m'orienter | S | 0.5 |
| US-1.4.3 | En tant qu'utilisateur, je veux acceder a cet ecran depuis la home afin d'y aller facilement | S | 0.5 |
| US-1.4.4 | En tant que developpeur, je veux un Bloc + datasource dedies afin de structurer le chargement des cours | M | 1 |

- **Effort total** : 3 jours
- **Dependances** : Feature 1.3 (point d'entree depuis la home)

### Feature 1.5 - Quran Listing

- **Complexite** : Moyenne
- **Description** : Ecran affichant la liste complete des sourates avec recherche, et la derniere sourate consultee mise en avant. Accessible depuis le Home Screen.
- **Lot** : Set 1

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.5.1 | En tant qu'utilisateur, je veux voir la liste complete des sourates avec recherche afin de trouver rapidement celle que je veux lire | M | 1 |
| US-1.5.2 | En tant qu'utilisateur, je veux voir ma derniere sourate consultee mise en avant afin de reprendre ma lecture rapidement | S | 0.5 |
| US-1.5.3 | En tant qu'utilisateur, je veux taper sur une sourate pour ouvrir sa page de lecture afin de commencer a lire | S | 0.5 |

- **Effort total** : 2 jours
- **Dependances** : Feature 1.3 (point d'entree depuis la home)

### Feature 1.6 - Recitation Test

- **Complexite** : Complexe
- **Description** : NOUVEAU - Ecran de validation de la recitation en temps reel. L'utilisateur recite une sourate courte (Al-Fatiha) a voix haute ; l'app streame l'audio du micro via WebSocket vers un backend Django qui relaie a Deepgram (STT streaming), compare les mots reconnus lettre par lettre aux mots attendus du Coran, et renvoie un verdict par mot. Chaque mot devient vert (correct) ou rouge (faux/oublie) en temps reel. Lancee depuis la 4e action de la home (anciennement "Quran reflection"). Spec detaillee : `docs/specs/recitation-test/`.
- **Lot** : Set 3

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.6.1 | En tant qu'utilisateur, je veux ouvrir l'ecran "Recitation Test" depuis la home afin de m'entrainer a reciter | XS | 0.25 |
| US-1.6.2 | En tant qu'utilisateur, je veux voir la sourate affichee mot par mot dans une couleur neutre afin de savoir ce que je dois reciter | S | 0.5 |
| US-1.6.3 | En tant qu'utilisateur, je veux demarrer et arreter l'enregistrement (avec gestion de la permission micro) afin de controler ma session | S | 0.5 |
| US-1.6.4 | En tant qu'utilisateur, je veux que chaque mot devienne vert (correct) ou rouge (faux) en temps reel pendant que je recite afin d'avoir un retour immediat | M | 1 |
| US-1.6.5 | En tant qu'utilisateur, je veux reinitialiser la session pour reessayer afin de m'entrainer plusieurs fois | XS | 0.25 |

- **Effort total** : 2.5 jours (frontend ; backend Django + integration Deepgram comptes separement)
- **Dependances** : Backend Django + Deepgram (validation complete). Aucune dependance de navigation.

### Feature 1.7 - Quran-Page Recitation

- **Complexite** : Complexe
- **Description** : NOUVEAU - Mode recitation/memorisation directement dans la page de lecture du Coran. L'utilisateur active un "mode recitation" depuis une barre en bas de page et recite la page affichee a voix haute ; les mots reellement rendus se colorent en place (vert = correct, rouge = faux) en temps reel. La barre offre : enregistrement on/off, masquage du texte (chaque mot ne se revele qu'une fois recite, pour la memorisation), recommencer (pointeur au debut de la page) et sourate suivante. L'enregistrement s'arrete automatiquement en fin de page. Un bouton flottant permet de demarrer d'une position precise (verset selectionne). Reutilise le pipeline IA de la Feature 1.6 (Flutter ⇄ Django Channels ⇄ Deepgram) sans nouveau code serveur. Spec detaillee : `docs/specs/recitation/`.
- **Lot** : Set 3

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-1.7.1 | En tant qu'utilisateur, je veux activer un "mode recitation" depuis une barre en bas de la page Coran afin d'entrainer ma recitation sur la page affichee | S | 0.5 |
| US-1.7.2 | En tant qu'utilisateur, je veux demarrer / arreter l'enregistrement depuis la barre afin de controler ma session | S | 0.5 |
| US-1.7.3 | En tant qu'utilisateur, je veux que les mots affiches sur la page deviennent verts / rouges en temps reel afin d'avoir un retour immediat sans changer d'ecran | M | 1 |
| US-1.7.4 | En tant qu'utilisateur, je veux masquer le texte de la page (chaque mot se revele une fois recite) afin de m'auto-tester pour la memorisation | M | 1 |
| US-1.7.5 | En tant qu'utilisateur, je veux un bouton "recommencer" qui remet le pointeur au debut de la page afin de reessayer | XS | 0.25 |
| US-1.7.6 | En tant qu'utilisateur, je veux un bouton "suivant" qui saute a la sourate suivante afin d'enchainer les courtes sourates | S | 0.5 |
| US-1.7.7 | En tant qu'utilisateur, je veux que l'enregistrement s'arrete automatiquement en fin de page afin de ne pas avoir a l'arreter manuellement | S | 0.5 |
| US-1.7.8 | En tant qu'utilisateur, je veux demarrer la recitation depuis une position precise via un bouton flottant afin de reprendre ou je veux | S | 0.5 |

- **Effort total** : ~4.75 jours (frontend ; backend reutilise de la Feature 1.6)
- **Dependances** : Feature 1.6 (contrat WebSocket + backend Django/Deepgram), page Coran existante (`quran/page`).

---

## Module 3 : Settings

Personnalisation de l'application (theme, langue, preferences utilisateur).

### Feature 3.1 - Settings Theme Toggle

- **Complexite** : Moyenne
- **Description** : Ajouter un toggle dans l'ecran Settings permettant a l'utilisateur de basculer entre theme clair et theme sombre. La preference est persistee localement et appliquee immediatement. S'appuie sur l'infrastructure `AppThemes` (light + dark partiel) deja presente dans `lib/src/app/design/themes/` et sur le pattern `LocalePreferenceService` pour la persistance.
- **Lot** : Set 2

| ID | User Story | Taille | Jours |
|----|-----------|--------|-------|
| US-3.1.1 | En tant qu'utilisateur, je veux voir mon theme actuel (clair/sombre) sur l'ecran Settings afin de savoir quel mode est actif | S | 0.5 |
| US-3.1.2 | En tant qu'utilisateur, je veux basculer le theme via un toggle/switch afin de changer l'apparence de l'app instantanement | M | 1 |
| US-3.1.3 | En tant qu'utilisateur, je veux que mon choix de theme soit persiste afin qu'il soit applique au prochain demarrage | S | 0.5 |
| US-3.1.4 | En tant qu'utilisateur, je veux que le theme sombre soit visuellement coherent (palette inversee, contrastes) afin de garder la qualite visuelle | M | 1 |

- **Effort total** : 3 jours
- **Dependances** : Aucune

