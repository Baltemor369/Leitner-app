import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/ui/feedback.dart';
import '../decks/deck_providers.dart';
import 'card_editor.dart';
import 'card_providers.dart';

/// Liste et gestion des cartes d'un paquet (UC2, EF-4/EF-5/EF-6).
class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key, required this.deckId, required this.deckName});

  final int deckId;
  final String deckName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsForDeckProvider(deckId));

    return Scaffold(
      appBar: AppBar(title: Text(deckName)),
      body: cards.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            const Center(child: Text('Impossible de charger les cartes.')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Aucune carte. Ajoutez-en une.'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) => _CardTile(card: items[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addCard(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle carte'),
      ),
    );
  }

  Future<void> _addCard(BuildContext context, WidgetRef ref) async {
    final result = await showCardEditor(context);
    if (result == null || !context.mounted) return;
    final ok = await runGuarded(
      context,
      () => ref.read(cardRepositoryProvider).createCard(
            deckId: deckId,
            front: result.front,
            back: result.back,
          ),
    );
    if (ok) _refresh(ref, deckId);
  }
}

void _refresh(WidgetRef ref, int deckId) {
  ref.invalidate(cardsForDeckProvider(deckId));
  ref.invalidate(deckSummariesProvider); // compteurs de l'accueil
}

class _CardTile extends ConsumerWidget {
  const _CardTile({required this.card});

  final Card card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(child: Text('${card.box}')),
      title: Text(
        card.front ?? '(image)',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        card.back ?? '(image)',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (action) => _onAction(context, ref, action),
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'edit', child: Text('Modifier')),
          PopupMenuItem(value: 'delete', child: Text('Supprimer')),
        ],
      ),
    );
  }

  Future<void> _onAction(
      BuildContext context, WidgetRef ref, String action) async {
    switch (action) {
      case 'edit':
        final result = await showCardEditor(
          context,
          initialFront: card.front,
          initialBack: card.back,
        );
        if (result == null || !context.mounted) return;
        final ok = await runGuarded(
          context,
          () => ref.read(cardRepositoryProvider).updateCardContent(
                id: card.id,
                front: Value(result.front),
                back: Value(result.back),
              ),
        );
        if (ok) _refresh(ref, card.deckId);
      case 'delete':
        final confirmed = await confirmDialog(
          context,
          title: 'Supprimer la carte ?',
          message: 'Cette carte sera définitivement supprimée.',
        );
        if (!confirmed || !context.mounted) return;
        final ok = await runGuarded(
          context,
          () => ref.read(cardRepositoryProvider).deleteCard(card.id),
        );
        if (ok) _refresh(ref, card.deckId);
    }
  }
}
