# Cahier des Charges — Leitner

> Application mobile d'apprentissage par répétition espacée, basée sur la **méthode de Leitner**.

- **Version du document** : 0.1.0
- **Date** : 2026-06-20
- **Statut** : Validé pour le MVP

---

## 1. Contexte et vision

La **méthode de Leitner** est une technique d'apprentissage par répétition espacée. Les cartes
(question/réponse) sont réparties dans un système de **boîtes** : une carte bien sue monte d'une
boîte (révisée moins souvent), une carte ratée redescend en boîte 1 (révisée plus souvent). Ce
mécanisme concentre l'effort sur ce qui n'est pas encore acquis et exploite l'effet de la
révision régulière et espacée pour ancrer les notions en mémoire à long terme.

**Vision** : offrir une application mobile **simple, rapide et hors-ligne** qui rend cette méthode
accessible au quotidien, en s'appuyant sur des rappels réguliers pour entretenir la régularité.

**Différenciateur** : à la différence des applications Leitner existantes, les cartes peuvent porter
une **image** (sur le recto et/ou le verso). Ce support visuel est essentiel pour des usages comme
l'apprentissage d'écritures pictographiques (ex. japonais), ou la reconnaissance de plantes, animaux,
œuvres, etc. C'est un élément central du produit, intégré dès le MVP.

---

## 2. Objectifs

### Objectif principal
Livrer un **MVP publiable** sur les stores (Android + iOS) permettant à un utilisateur de créer
ses cartes, de les réviser selon le rythme Leitner, et d'être rappelé chaque jour.

### Objectifs détaillés
- Permettre la création et la gestion de cartes recto/verso, **avec image optionnelle** de chaque côté.
- Implémenter le moteur Leitner (5 boîtes, intervalles fixes).
- Proposer une session de révision quotidienne basée sur les cartes « dues ».
- Notifier l'utilisateur des cartes à réviser pour entretenir la régularité.
- Fonctionner **entièrement hors-ligne**, sans création de compte.

### Objectifs non visés par le MVP (voir §9 Backlog)
Synchronisation cloud, import/export, médias audio et formules LaTeX, decks pré-faits,
statistiques avancées, internationalisation. _(Les images, elles, font partie du MVP.)_

---

## 3. Périmètre

### 3.1 Dans le périmètre MVP
- Gestion des **decks** (paquets de cartes) : créer, renommer, supprimer.
- Gestion des **cartes** : créer, éditer, supprimer (recto/verso : texte **et/ou image**).
- **Moteur Leitner** : 5 boîtes, planification des révisions.
- **Session de révision** : afficher les cartes dues, valider « su / pas su ».
- **Notifications locales** quotidiennes.
- **Statistiques simples** : répartition par boîte, révisions du jour, série (streak).
- **Thème clair / sombre**.
- Interface en **français**.

### 3.2 Hors périmètre MVP
Voir §9 (Backlog produit).

---

## 4. Acteurs et cas d'usage

**Acteur unique** : l'_Apprenant_ (utilisateur de l'app, hors-ligne, sans compte).

| ID | Cas d'usage | Description |
|----|-------------|-------------|
| UC1 | Créer un deck | L'apprenant crée un paquet thématique. |
| UC2 | Ajouter une carte | Saisie recto (question) + verso (réponse), affectée à un deck, placée en boîte 1. |
| UC3 | Réviser | L'app présente les cartes dues ; l'apprenant répond, voit la solution, et indique « su » ou « pas su ». |
| UC4 | Progresser | « Su » → la carte monte d'une boîte ; « pas su » → retour en boîte 1. La prochaine date de révision est recalculée. |
| UC5 | Être rappelé | Notification quotidienne indiquant le nombre de cartes à réviser. |
| UC6 | Consulter sa progression | Tableau de bord : cartes par boîte, révisions effectuées, streak. |

---

## 5. Exigences fonctionnelles

### 5.1 Decks
- EF-1 : Créer un deck avec un nom.
- EF-2 : Lister les decks avec, pour chacun, le nombre de cartes et le nombre de cartes dues.
- EF-3 : Renommer et supprimer un deck (suppression en cascade des cartes, avec confirmation).

### 5.2 Cartes
- EF-4 : Créer une carte (recto + verso) rattachée à un deck ; elle démarre en **boîte 1**
  avec une date de révision = aujourd'hui.
- EF-5 : Éditer le contenu d'une carte sans réinitialiser sa progression.
- EF-6 : Supprimer une carte (avec confirmation).
- EF-6a : Chaque face d'une carte peut contenir du **texte et/ou une image**. Une carte est valide
  si au moins l'une des deux faces a un contenu (texte ou image).
- EF-6b : L'image est choisie depuis la **galerie** ou la **caméra** du téléphone, puis copiée dans
  le stockage interne de l'application (indépendance vis-à-vis du fichier source).
- EF-6c : L'image peut être **remplacée ou retirée** lors de l'édition. La suppression d'une carte
  (ou d'un deck) supprime les fichiers image associés (pas de fichiers orphelins).

### 5.3 Moteur Leitner
- EF-7 : **5 boîtes**. Intervalles de révision fixes par boîte :

  | Boîte | Intervalle après réussite |
  |:-----:|:-------------------------:|
  | 1 | +1 jour |
  | 2 | +3 jours |
  | 3 | +7 jours |
  | 4 | +14 jours |
  | 5 | +30 jours |

- EF-8 : Une carte est **due** si sa `date_prochaine_revision` ≤ aujourd'hui.
- EF-9 : Réponse **« su »** → la carte monte d'une boîte (plafonnée à 5) ; `date_prochaine_revision`
  = aujourd'hui + intervalle de la **nouvelle** boîte.
- EF-10 : Réponse **« pas su »** → la carte retourne en **boîte 1** ; `date_prochaine_revision`
  = aujourd'hui + 1 jour.
- EF-11 : Une carte en boîte 5 répondue « su » reste en boîte 5 (replanifiée à +30 jours).

### 5.4 Session de révision
- EF-12 : Démarrer une session (tous decks ou un deck choisi) regroupant les cartes dues.
- EF-13 : Présenter le recto, permettre de **révéler** le verso, puis recueillir « su / pas su ».
- EF-14 : Afficher la progression de la session (ex. « 4 / 12 ») et un écran de fin.
- EF-15 : Une carte révisée n'est pas représentée dans la même session (sauf option future).

### 5.5 Notifications
- EF-16 : Notification **locale** quotidienne, à une heure par défaut (ex. 19h00), indiquant le
  nombre de cartes dues. Pas de notification si 0 carte due.
- EF-17 : L'utilisateur peut activer/désactiver le rappel et choisir l'heure.

### 5.6 Statistiques
- EF-18 : Répartition des cartes par boîte (cœur de la motivation Leitner).
- EF-19 : Nombre de cartes révisées aujourd'hui et nombre restant.
- EF-20 : **Streak** (nombre de jours consécutifs avec au moins une révision).

### 5.7 Réglages
- EF-21 : Choix du thème (clair / sombre / système).
- EF-22 : Réglages de notification (cf. EF-17).

---

## 6. Exigences non fonctionnelles

- ENF-1 : **Hors-ligne total** — aucune dépendance réseau pour les fonctions cœur.
- ENF-2 : **Confidentialité** — données stockées uniquement sur l'appareil, aucun envoi externe.
- ENF-3 : **Performance** — démarrage et ouverture d'une session < 1 s pour ~1000 cartes.
- ENF-4 : **Fiabilité des données** — persistance transactionnelle ; aucune perte de progression.
- ENF-5 : **Accessibilité** — tailles de police lisibles, contrastes suffisants, zones tactiles ≥ 44 px.
- ENF-6 : **Compatibilité** — Android 8+ (API 26) et iOS 13+.
- ENF-7 : **Maintenabilité** — code organisé en couches (UI / logique métier / données), testable.

---

## 7. Architecture technique

### 7.1 Stack
- **Framework** : Flutter (Dart) — un seul code pour Android et iOS.
- **Persistance locale** : SQLite (via `sqflite` ou `drift`). `drift` recommandé pour le typage et
  les requêtes testables.
- **Gestion d'état** : `Riverpod` (recommandé) ou `Bloc` — à confirmer à l'implémentation.
- **Notifications locales** : `flutter_local_notifications` (+ `timezone` pour la planification).
- **Stockage des réglages** : `shared_preferences`.
- **Images** : `image_picker` (galerie/caméra) + `path_provider` (répertoire applicatif où sont
  copiées les images). Seul le **chemin** de l'image est stocké en base ; le fichier vit dans le
  stockage interne de l'app. Compression/redimensionnement à la sélection (limiter le poids).

### 7.2 Découpage en couches
```
lib/
  features/        # Découpage par domaine fonctionnel
    decks/
    cards/
    review/
    stats/
    settings/
  core/
    leitner/       # Moteur Leitner (logique pure, testable sans UI)
    database/      # Schéma et accès données (drift)
    notifications/ # Planification des rappels
    theme/
  main.dart
```
Le **moteur Leitner** (`core/leitner`) est une logique pure, sans dépendance UI ni I/O, afin
d'être couvert par des tests unitaires exhaustifs.

### 7.3 Modèle de données

**Deck**
| Champ | Type | Notes |
|-------|------|-------|
| id | INTEGER | PK |
| name | TEXT | non vide |
| created_at | DATETIME | |

**Card**
| Champ | Type | Notes |
|-------|------|-------|
| id | INTEGER | PK |
| deck_id | INTEGER | FK → Deck, cascade à la suppression |
| front | TEXT | recto, texte (nullable) |
| back | TEXT | verso, texte (nullable) |
| front_image_path | TEXT | chemin de l'image du recto (nullable) |
| back_image_path | TEXT | chemin de l'image du verso (nullable) |
| box | INTEGER | 1..5 |
| next_review_date | DATE | date de prochaine révision |
| created_at | DATETIME | |
| updated_at | DATETIME | |

**ReviewLog** (alimente streak et stats)
| Champ | Type | Notes |
|-------|------|-------|
| id | INTEGER | PK |
| card_id | INTEGER | FK → Card |
| reviewed_at | DATETIME | |
| was_correct | BOOLEAN | « su » / « pas su » |
| box_before | INTEGER | |
| box_after | INTEGER | |

---

## 8. Jalons / livrables

| Jalon | Contenu | Livrable |
|-------|---------|----------|
| J0 — Cadrage | Ce CdC validé, projet Flutter initialisé, version 0.1.0 | Repo + `docs/CDC.md` |
| J1 — Moteur | `core/leitner` + schéma `drift` + tests unitaires du moteur | Logique métier testée |
| J2 — CRUD | Écrans decks & cartes (création/édition/suppression) | Gestion de contenu |
| J3 — Révision | Session de révision complète (UC3/UC4) | Boucle d'apprentissage fonctionnelle |
| J4 — Rappels & stats | Notifications locales + tableau de bord | Régularité + motivation |
| J5 — Finition | Thème clair/sombre, accessibilité, polish, build stores | **MVP publiable (v1.0.0)** |

---

## 9. Backlog produit (post-MVP)

Fonctionnalités explicitement reportées, à prioriser après le MVP :

- **Synchronisation cloud** multi-appareils (compte utilisateur, Firebase/Supabase).
- **Import / export** : CSV et paquets Anki (`.apkg`).
- **Médias riches complémentaires** : audio et formules LaTeX sur les cartes. _(Les images font
  désormais partie du MVP, cf. §5.2.)_
- **Decks pré-faits** : catalogue de paquets thématiques fournis avec l'app.
- **Boîtes & intervalles paramétrables**, voire algorithme adaptatif (type SM-2).
- **Statistiques avancées** : graphes d'évolution, historique détaillé, prévisions de charge.
- **Internationalisation** (EN puis autres langues).
- **Réglages de notifications avancés** (plusieurs rappels, jours sélectionnés).

---

## 10. Contraintes et hypothèses

- Développement **solo** : périmètre MVP volontairement resserré.
- Pas de budget backend au MVP → choix **offline-first** assumé.
- Versionnage **SemVer** ; bump à chaque commit, tag `vX.Y.Z` aux push/releases.
- Publication stores soumise aux comptes développeur Google Play / Apple (hors périmètre technique).
