# Changelog

Toutes les modifications notables de ce projet sont consignées dans ce fichier.

Le format s'appuie sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et le projet suit le [versionnage sémantique](https://semver.org/lang/fr/).

## [0.3.0] - 2026-06-21

### Ajouté
- Interface de gestion (Riverpod) : écran d'accueil listant les paquets avec
  compteurs (total + cartes dues), création/renommage/suppression de paquets,
  et écran de cartes par paquet avec création/édition/suppression (EF-1 à EF-6).
- Éditeur de carte (recto/verso texte) avec validation « au moins une face ».
- Thème clair/sombre suivant le système (EF-21).
- Helper UI partagé : dialogue de confirmation et exécution protégée des
  opérations asynchrones (SnackBar en cas d'erreur).
- Widget-tests du parcours (création de paquet, ajout de carte, confirmation de
  suppression) ; suite complète 29/29 au vert.

### Corrigé (revue avant commit)
- Suppression de carte désormais **confirmée** (EF-6).
- Mutations asynchrones protégées (plus d'exception non gérée) avec garde
  `context.mounted` après chaque `await`.
- `TextEditingController` du dialogue de nom correctement libéré (plus de fuite).
- Troncature (ellipsis) des titres pour éviter les débordements de mise en page.

### Connu
- L'éditeur de carte ne gère pas encore les images (prévu avec la couche
  d'import d'images, J2.5) ; la base de données les supporte déjà.

## [0.2.0] - 2026-06-21

### Ajouté
- Couche de données locale SQLite via **drift** : tables `Decks`, `Cards`
  (texte et/ou image par face), `ReviewLogs`, avec suppression en cascade.
- Dépôts d'accès : `DeckRepository` (CRUD + comptes total/dues),
  `CardRepository` (création, édition partielle non destructrice, suppression,
  cartes dues) et `ReviewRepository` (application de Leitner en transaction +
  journalisation), couverts par 20 tests d'intégration (base en mémoire).
- Utilitaires de dates partagés (`core/util/dates.dart`).

### Modifié
- `next_review_date` stocké en **date pure ISO « yyyy-MM-dd »** (et non en
  instant), rendant la logique « due » insensible au fuseau horaire et au DST.
- Le moteur Leitner réutilise désormais les utilitaires de dates partagés.

### Sécurité
- Validation des chemins d'images (rejet des chemins vides ou contenant `..`).
- `updateCardContent` et `deleteDeck`/`deleteCard` renvoient les fichiers image
  à effacer (prévention des orphelins, EF-6c).

### Connu / accepté pour le MVP
- Base non chiffrée au repos (sandbox OS jugé suffisant pour des données
  d'apprentissage locales). Chiffrement (SQLCipher) envisagé post-MVP.
- Invariant `box ∈ 1..5` garanti par le moteur, pas par une contrainte SQL.

## [0.1.0] - 2026-06-20

### Ajouté
- Cahier des charges du projet Leitner (`docs/CDC.md`) : contexte, objectifs, périmètre
  MVP vs backlog, exigences fonctionnelles et non fonctionnelles, architecture technique
  (Flutter + SQLite, offline-first), modèle de données, jalons.
- Initialisation du versionnage (SemVer) avec le fichier `VERSION`.
- Squelette du projet Flutter (Android + iOS) avec découpage en couches (§7.2 du CdC) :
  `lib/core/{leitner,database,notifications,theme}` et `lib/features/{decks,cards,review,stats,settings}`.
- Moteur Leitner pur (`lib/core/leitner/leitner_engine.dart`) : intervalles J+1/+3/+7/+14/+30,
  règles de progression (EF-8 à EF-11), couvert par 6 tests unitaires.
- CdC : prise en charge des **images sur les cartes** (recto/verso) intégrée au périmètre MVP —
  différenciateur produit pour l'apprentissage pictographique (japonais) et la reconnaissance
  (plantes, animaux). Exigences EF-6a/6b/6c, modèle de données et dépendances mis à jour.
