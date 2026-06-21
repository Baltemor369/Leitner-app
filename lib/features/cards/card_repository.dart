import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../core/util/dates.dart';

/// Accès aux cartes (cf. EF-4 à EF-6c).
class CardRepository {
  CardRepository(this._db);

  final AppDatabase _db;

  /// Crée une carte et renvoie son identifiant (EF-4).
  ///
  /// La carte démarre en boîte 1, due le jour même. Une carte doit avoir au
  /// moins une face non vide (texte ou image) — EF-6a.
  Future<int> createCard({
    required int deckId,
    String? front,
    String? back,
    String? frontImagePath,
    String? backImagePath,
    DateTime? today,
  }) {
    final cleanFront = _blankToNull(front);
    final cleanBack = _blankToNull(back);
    final cleanFrontImg = _validatedImagePath(frontImagePath);
    final cleanBackImg = _validatedImagePath(backImagePath);
    _requireSomeContent(cleanFront, cleanBack, cleanFrontImg, cleanBackImg);

    return _db.into(_db.cards).insert(
          CardsCompanion.insert(
            deckId: deckId,
            front: Value(cleanFront),
            back: Value(cleanBack),
            frontImagePath: Value(cleanFrontImg),
            backImagePath: Value(cleanBackImg),
            nextReviewDate: dateOnly(today ?? DateTime.now()),
          ),
        );
  }

  /// Met à jour le contenu d'une carte **sans** réinitialiser sa progression
  /// (boîte et date de révision inchangées) — EF-5.
  ///
  /// Chaque champ utilise la sémantique `Value` : un argument **absent** laisse
  /// le champ inchangé, `Value(null)` le vide, `Value('x')` le remplace. Cela
  /// permet d'éditer une seule face sans écraser les autres. Renvoie les
  /// chemins d'images qui ne sont plus référencés (à effacer par l'appelant) —
  /// EF-6c. Lève [StateError] si la carte n'existe pas.
  Future<List<String>> updateCardContent({
    required int id,
    Value<String?> front = const Value.absent(),
    Value<String?> back = const Value.absent(),
    Value<String?> frontImagePath = const Value.absent(),
    Value<String?> backImagePath = const Value.absent(),
    DateTime? now,
  }) {
    return _db.transaction(() async {
      final card = await (_db.select(_db.cards)..where((c) => c.id.equals(id)))
          .getSingleOrNull();
      if (card == null) {
        throw StateError('Carte introuvable: $id');
      }

      final newFront = front.present ? _blankToNull(front.value) : card.front;
      final newBack = back.present ? _blankToNull(back.value) : card.back;
      final newFrontImg = frontImagePath.present
          ? _validatedImagePath(frontImagePath.value)
          : card.frontImagePath;
      final newBackImg = backImagePath.present
          ? _validatedImagePath(backImagePath.value)
          : card.backImagePath;
      _requireSomeContent(newFront, newBack, newFrontImg, newBackImg);

      await (_db.update(_db.cards)..where((c) => c.id.equals(id))).write(
        CardsCompanion(
          front: Value(newFront),
          back: Value(newBack),
          frontImagePath: Value(newFrontImg),
          backImagePath: Value(newBackImg),
          updatedAt: Value(now ?? DateTime.now()),
        ),
      );

      return _replacedImages(card, newFrontImg, newBackImg);
    });
  }

  /// Supprime une carte (EF-6). Renvoie les chemins d'images à effacer (EF-6c).
  Future<List<String>> deleteCard(int id) {
    return _db.transaction(() async {
      final card = await (_db.select(_db.cards)..where((c) => c.id.equals(id)))
          .getSingleOrNull();
      if (card == null) return const <String>[];
      await (_db.delete(_db.cards)..where((c) => c.id.equals(id))).go();
      return [card.frontImagePath, card.backImagePath]
          .whereType<String>()
          .toList();
    });
  }

  /// Toutes les cartes d'un deck, les plus récentes d'abord.
  Future<List<Card>> getCardsForDeck(int deckId) {
    return (_db.select(_db.cards)
          ..where((c) => c.deckId.equals(deckId))
          ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]))
        .get();
  }

  /// Cartes dues (next_review_date <= aujourd'hui) — EF-8/EF-12.
  ///
  /// Si [deckId] est fourni, restreint à ce deck. Triées par boîte croissante
  /// puis par date de révision (les plus en retard d'abord).
  Future<List<Card>> getDueCards({int? deckId, DateTime? today}) {
    final todayIso = isoDate(today ?? DateTime.now());
    final query = _db.select(_db.cards)
      ..where((c) => c.nextReviewDate.isSmallerOrEqualValue(todayIso))
      ..orderBy([
        (c) => OrderingTerm(expression: c.box),
        (c) => OrderingTerm(expression: c.nextReviewDate),
      ]);
    if (deckId != null) {
      query.where((c) => c.deckId.equals(deckId));
    }
    return query.get();
  }

  /// Images de [card] qui ne sont plus utilisées après mise à jour.
  List<String> _replacedImages(Card card, String? newFront, String? newBack) {
    final removed = <String>[];
    if (card.frontImagePath != null && card.frontImagePath != newFront) {
      removed.add(card.frontImagePath!);
    }
    if (card.backImagePath != null && card.backImagePath != newBack) {
      removed.add(card.backImagePath!);
    }
    return removed;
  }

  void _requireSomeContent(
    String? front,
    String? back,
    String? frontImagePath,
    String? backImagePath,
  ) {
    final hasContent = front != null ||
        back != null ||
        frontImagePath != null ||
        backImagePath != null;
    if (!hasContent) {
      throw ArgumentError(
          'Une carte doit avoir au moins une face non vide (texte ou image).');
    }
  }

  String? _blankToNull(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  /// Garde-fou contre les chemins d'images invalides (vide, ou tentative de
  /// remontée de répertoire). La copie réelle dans le stockage interne et la
  /// génération du nom de fichier relèvent de la future couche « images ».
  String? _validatedImagePath(String? path) {
    if (path == null) return null;
    final trimmed = path.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed.contains('..')) {
      throw ArgumentError.value(path, 'imagePath', 'Chemin d\'image invalide');
    }
    return trimmed;
  }
}
