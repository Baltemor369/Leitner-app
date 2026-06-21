import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/ui/feedback.dart';
import '../cards/cards_screen.dart';
import 'deck_providers.dart';
import 'deck_repository.dart';

/// Écran d'accueil : liste des paquets de cartes (UC1, EF-1/EF-2/EF-3).
class DecksScreen extends ConsumerWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(deckSummariesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes paquets')),
      body: decks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(
          child: Text('Impossible de charger les paquets.'),
        ),
        data: (summaries) {
          if (summaries.isEmpty) {
            return const _EmptyState();
          }
          return ListView.builder(
            itemCount: summaries.length,
            itemBuilder: (context, i) => _DeckTile(summary: summaries[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createDeck(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nouveau paquet'),
      ),
    );
  }

  Future<void> _createDeck(BuildContext context, WidgetRef ref) async {
    final name = await promptDeckName(context, title: 'Nouveau paquet');
    if (name == null || !context.mounted) return;
    final ok = await runGuarded(
      context,
      () => ref.read(deckRepositoryProvider).createDeck(name),
    );
    if (ok) ref.invalidate(deckSummariesProvider);
  }
}

class _DeckTile extends ConsumerWidget {
  const _DeckTile({required this.summary});

  final DeckSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueLabel =
        summary.dueCount > 0 ? '${summary.dueCount} à réviser' : 'À jour';
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.style)),
      title: Text(
        summary.deck.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('${summary.cardCount} carte(s) · $dueLabel'),
      trailing: PopupMenuButton<String>(
        onSelected: (action) => _onAction(context, ref, action),
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'rename', child: Text('Renommer')),
          PopupMenuItem(value: 'delete', child: Text('Supprimer')),
        ],
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CardsScreen(
            deckId: summary.deck.id,
            deckName: summary.deck.name,
          ),
        ),
      ),
    );
  }

  Future<void> _onAction(
      BuildContext context, WidgetRef ref, String action) async {
    switch (action) {
      case 'rename':
        final name = await promptDeckName(
          context,
          title: 'Renommer le paquet',
          initial: summary.deck.name,
        );
        if (name == null || !context.mounted) return;
        final ok = await runGuarded(
          context,
          () => ref.read(deckRepositoryProvider).renameDeck(summary.deck.id, name),
        );
        if (ok) ref.invalidate(deckSummariesProvider);
      case 'delete':
        final confirmed = await confirmDialog(
          context,
          title: 'Supprimer le paquet ?',
          message:
              '« ${summary.deck.name} » et toutes ses cartes seront définitivement supprimés.',
        );
        if (!confirmed || !context.mounted) return;
        final ok = await runGuarded(
          context,
          () => ref.read(deckRepositoryProvider).deleteDeck(summary.deck.id),
        );
        if (ok) ref.invalidate(deckSummariesProvider);
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.style_outlined, size: 64),
            const SizedBox(height: 16),
            Text(
              'Aucun paquet pour l\'instant.\nCréez-en un pour commencer.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

/// Boîte de dialogue de saisie/édition du nom d'un paquet. Renvoie le nom
/// nettoyé (non vide), ou `null` si annulé.
Future<String?> promptDeckName(
  BuildContext context, {
  required String title,
  String initial = '',
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _DeckNameDialog(title: title, initial: initial),
  );
}

/// Dialogue à état dédié : possède et libère son [TextEditingController].
class _DeckNameDialog extends StatefulWidget {
  const _DeckNameDialog({required this.title, required this.initial});

  final String title;
  final String initial;

  @override
  State<_DeckNameDialog> createState() => _DeckNameDialogState();
}

class _DeckNameDialogState extends State<_DeckNameDialog> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    if (value.isNotEmpty) Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 100,
        decoration: const InputDecoration(labelText: 'Nom du paquet'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Valider')),
      ],
    );
  }
}
