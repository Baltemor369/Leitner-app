import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../core/leitner/leitner_engine.dart';
import '../../core/util/dates.dart';

/// Applique la révision des cartes selon la méthode de Leitner (cf. EF-9 à
/// EF-11) et journalise chaque révision (alimente les stats — EF-18 à EF-20).
class ReviewRepository {
  ReviewRepository(this._db);

  final AppDatabase _db;

  /// Enregistre le résultat d'une révision pour la carte [cardId].
  ///
  /// La carte est **relue dans la transaction** (et non passée en argument)
  /// pour calculer la progression à partir de l'état réellement stocké : cela
  /// évite les incohérences en cas d'objet périmé ou de double-validation. Met
  /// à jour la carte et insère l'historique de façon atomique, puis renvoie le
  /// résultat appliqué. Lève [StateError] si la carte n'existe pas.
  Future<ReviewOutcome> reviewCard({
    required int cardId,
    required bool wasCorrect,
    DateTime? today,
  }) {
    return _db.transaction(() async {
      final card = await (_db.select(_db.cards)
            ..where((c) => c.id.equals(cardId)))
          .getSingleOrNull();
      if (card == null) {
        throw StateError('Carte introuvable: $cardId');
      }

      final outcome = applyReview(
        currentBox: card.box,
        wasCorrect: wasCorrect,
        today: today,
      );

      await (_db.update(_db.cards)..where((c) => c.id.equals(cardId))).write(
        CardsCompanion(
          box: Value(outcome.newBox),
          nextReviewDate: Value(outcome.nextReviewDate),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await _db.into(_db.reviewLogs).insert(
            ReviewLogsCompanion.insert(
              cardId: cardId,
              wasCorrect: wasCorrect,
              boxBefore: card.box,
              boxAfter: outcome.newBox,
            ),
          );

      return outcome;
    });
  }

  /// Nombre de cartes dues (toutes ou pour un deck) — utile aux rappels (EF-16).
  Future<int> countDueCards({int? deckId, DateTime? today}) async {
    final todayIso = isoDate(today ?? DateTime.now());
    final cards = _db.cards;
    final countExp = cards.id.count();

    final query = _db.selectOnly(cards)..addColumns([countExp]);
    query.where(cards.nextReviewDate.isSmallerOrEqualValue(todayIso));
    if (deckId != null) {
      query.where(cards.deckId.equals(deckId));
    }

    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }
}
