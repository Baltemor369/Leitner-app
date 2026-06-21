import 'package:drift/drift.dart';

import '../util/dates.dart';

/// Convertit une date de révision entre `DateTime` (côté Dart) et un texte ISO
/// « yyyy-MM-dd » (côté SQLite). Stocker une **date pure** plutôt qu'un instant
/// rend la planification insensible au fuseau horaire et aux changements
/// d'heure (cf. dates.dart).
class DateOnlyConverter extends TypeConverter<DateTime, String> {
  const DateOnlyConverter();

  @override
  DateTime fromSql(String fromDb) => DateTime.parse(fromDb);

  @override
  String toSql(DateTime value) => isoDate(value);
}

/// Paquets de cartes (cf. CdC §7.3 — table Deck).
class Decks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// Cartes recto/verso (cf. CdC §7.3 — table Card).
///
/// Chaque face peut porter du texte et/ou une image (EF-6a) ; les colonnes
/// correspondantes sont donc nullable. La validité « au moins une face non
/// vide » est garantie au niveau applicatif (dépôt), pas par le schéma.
class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deckId =>
      integer().references(Decks, #id, onDelete: KeyAction.cascade)();
  TextColumn get front => text().nullable()();
  TextColumn get back => text().nullable()();
  TextColumn get frontImagePath => text().nullable()();
  TextColumn get backImagePath => text().nullable()();
  IntColumn get box => integer().withDefault(const Constant(1))();
  // Date pure (sans heure) stockée en texte ISO, cf. [DateOnlyConverter].
  TextColumn get nextReviewDate => text().map(const DateOnlyConverter())();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// Historique des révisions (cf. CdC §7.3 — table ReviewLog).
///
/// Alimente les statistiques et le streak (EF-18 à EF-20).
class ReviewLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId =>
      integer().references(Cards, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get reviewedAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get wasCorrect => boolean()();
  IntColumn get boxBefore => integer()();
  IntColumn get boxAfter => integer()();
}
