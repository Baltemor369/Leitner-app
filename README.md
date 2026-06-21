# Leitner

Application mobile d'apprentissage par **répétition espacée**, fondée sur la
[méthode de Leitner](https://fr.wikipedia.org/wiki/Syst%C3%A8me_Leitner) : les
cartes progressent à travers 5 boîtes selon qu'elles sont sues ou non, et sont
révisées à des intervalles croissants (J+1, +3, +7, +14, +30).

Particularité : les cartes peuvent porter une **image** (recto et/ou verso),
pour l'apprentissage pictographique (japonais…) ou la reconnaissance visuelle
(plantes, animaux…).

## État du projet

Version `0.2.0` — en développement. Voir le [cahier des charges](docs/CDC.md)
pour le périmètre, les exigences et les jalons, et le [CHANGELOG](CHANGELOG.md).

Réalisé :
- Cahier des charges complet.
- Moteur Leitner (logique pure, testée).
- Couche de données locale (SQLite via drift) : decks, cartes, révisions.

À venir : interface de gestion des decks/cartes, session de révision,
notifications de rappel, statistiques (cf. jalons J2→J5 du CdC).

## Stack

- **Flutter** (Android + iOS), offline-first, sans compte.
- **drift** (SQLite) pour la persistance locale typée et testable.

## Architecture (`lib/`)

```
core/
  leitner/    Moteur Leitner (logique pure, sans I/O)
  database/   Schéma drift, connexion, base
  util/       Utilitaires (dates DST-safe)
features/
  decks/ cards/ review/ stats/ settings/   Domaines fonctionnels
```

## Développement

```bash
flutter pub get
# Régénérer le code drift après modification du schéma :
dart run build_runner build --delete-conflicting-outputs
# Tests :
flutter test
```

> Construire/lancer l'app Android nécessite un JDK 11–19 (ou Android Studio, qui
> en embarque un). Les tests et la logique ne nécessitent pas de JDK.

## Licence

Voir [LICENSE](LICENSE).
