# Liste des Fonctions - Tajweed AI

> Document commercial decrivant les modules fonctionnels et leurs User Stories.
> Format : INVEST (Independent, Negotiable, Valuable, Estimable, Small, Testable).
> Tailles : XS (0.25j), S (0.5j), M (1j), L (2j), XL (3j).

---

## Statistiques

- **Modules** : 2 (Auth, Home)
- **Features** : 5
- **User Stories** : 20
- **Effort total** : 15 jours

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
