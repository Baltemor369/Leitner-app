# Changelog

Toutes les modifications notables de ce projet sont consignées dans ce fichier.

Le format s'appuie sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et le projet suit le [versionnage sémantique](https://semver.org/lang/fr/).

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
