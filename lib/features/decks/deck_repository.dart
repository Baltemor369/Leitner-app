import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../core/util/dates.dart';

/// Vue synthétique d'un deck pour les listes (cf. EF-2) : le deck, son nombre
/// total de cartes, et le nombre de cartes dues à la date de référence.
class DeckSummary {
  const DeckSummary({
    required this.deck,
    required this.cardCount,
    required this.dueCount,
  });

  final Deck deck;
  final int cardCount;
  final int dueCount;
}

/// Accès aux paquets de cartes (cf. EF-1 à EF-3).
class DeckRepository {
  DeckRepository(this._db);

  final AppDatabase _db;

  /// Crée un deck et renvoie son identifiant. Le nom est nettoyé (trim) et ne
  /// peut pas être vide (EF-1).
  Future<int> createDeck(String name) {
    final cleanName = _requireNonEmptyName(name);
    return _db.into(_db.decks).insert(DecksCompanion.insert(name: cleanName));
  }

  /// Renomme un deck (EF-3). Lève [StateError] si le deck n'existe pas.
  Future<void> renameDeck(int id, String name) async {
    final cleanName = _requireNonEmptyName(name);
    final updated = await (_db.update(_db.decks)..where((d) => d.id.equals(id)))
        .write(DecksCompanion(name: Value(cleanName)));
    if (updated == 0) {
      throw StateError('Deck introuvable: $id');
    }
  }

  /// Supprime un deck et, par cascade, ses cartes et leurs logs (EF-3).
  ///
  /// Renvoie les chemins des images des cartes supprimées, afin que la couche
  /// applicative efface les fichiers correspondants (EF-6c). La collecte des
  /// chemins et la suppression sont atomiques (aucune image orpheline si une
  /// carte est ajoutée entre-temps).
  Future<List<String>> deleteDeck(int id) {
    return _db.transaction(() async {
      final imagePaths = await _imagePathsForDeck(id);
      await (_db.delete(_db.decks)..where((d) => d.id.equals(id))).go();
      return imagePaths;
    });
  }

  /// Liste les decks avec leurs compteurs (total + dues), triés par nom (EF-2).
  Future<List<DeckSummary>> getDeckSummaries({DateTime? today}) async {
    final todayIso = isoDate(today ?? DateTime.now());

    final decks = await (_db.select(_db.decks)
          ..orderBy([(d) => OrderingTerm(expression: d.name)]))
        .get();

    final cards = _db.cards;
    final totalExp = cards.id.count();
    final dueExp = cards.id
        .count(filter: cards.nextReviewDate.isSmallerOrEqualValue(todayIso));

    final countQuery = _db.selectOnly(cards)
      ..addColumns([cards.deckId, totalExp, dueExp])
      ..groupBy([cards.deckId]);

    final countsByDeck = <int, ({int total, int due})>{};
    for (final row in await countQuery.get()) {
      final deckId = row.read(cards.deckId)!;
      countsByDeck[deckId] =
          (total: row.read(totalExp) ?? 0, due: row.read(dueExp) ?? 0);
    }

    return [
      for (final deck in decks)
        DeckSummary(
          deck: deck,
          cardCount: countsByDeck[deck.id]?.total ?? 0,
          dueCount: countsByDeck[deck.id]?.due ?? 0,
        ),
    ];
  }

  Future<List<String>> _imagePathsForDeck(int deckId) async {
    final cards = await (_db.select(_db.cards)
          ..where((c) => c.deckId.equals(deckId)))
        .get();
    return [
      for (final c in cards) ...[c.frontImagePath, c.backImagePath],
    ].whereType<String>().toList();
  }

  String _requireNonEmptyName(String name) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      throw ArgumentError.value(
          name, 'name', 'Le nom du deck ne peut pas être vide');
    }
    return cleanName;
  }
}
