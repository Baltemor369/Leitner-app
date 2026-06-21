import 'package:drift/drift.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// Base de données locale SQLite de l'application (cf. CdC §7.1/§7.3).
///
/// La connexion concrète (fichier sur l'appareil ou base en mémoire pour les
/// tests) est injectée via le constructeur, ce qui rend la base testable sans
/// dépendance à Flutter.
@DriftDatabase(tables: [Decks, Cards, ReviewLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          // Indispensable pour activer la suppression en cascade (FK).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
