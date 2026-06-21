import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';

/// Cartes d'un paquet donné (EF-2 côté détail). `family` indexée par deckId.
final cardsForDeckProvider =
    FutureProvider.autoDispose.family<List<Card>, int>(
  (ref, deckId) => ref.watch(cardRepositoryProvider).getCardsForDeck(deckId),
);
