import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import 'deck_repository.dart';

/// Liste des decks avec leurs compteurs (total + dues) — EF-2.
///
/// `autoDispose` : la liste est rechargée à chaque affichage de l'écran ; on
/// l'invalide explicitement après création/renommage/suppression.
final deckSummariesProvider = FutureProvider.autoDispose<List<DeckSummary>>(
  (ref) => ref.watch(deckRepositoryProvider).getDeckSummaries(),
);
