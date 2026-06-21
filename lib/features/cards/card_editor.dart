import 'package:flutter/material.dart';

/// Contenu saisi dans l'éditeur de carte (recto/verso texte).
///
/// La prise en charge des images (EF-6a/6b) sera ajoutée ici avec la couche
/// d'import d'images ; la base de données la supporte déjà.
class CardEditorResult {
  const CardEditorResult({this.front, this.back});

  final String? front;
  final String? back;
}

/// Affiche un formulaire de création/édition de carte. Renvoie le contenu
/// saisi, ou `null` si annulé. Validation : au moins une face non vide (EF-6a).
Future<CardEditorResult?> showCardEditor(
  BuildContext context, {
  String? initialFront,
  String? initialBack,
}) {
  return showDialog<CardEditorResult>(
    context: context,
    builder: (_) => _CardEditorDialog(
      initialFront: initialFront,
      initialBack: initialBack,
    ),
  );
}

class _CardEditorDialog extends StatefulWidget {
  const _CardEditorDialog({this.initialFront, this.initialBack});

  final String? initialFront;
  final String? initialBack;

  @override
  State<_CardEditorDialog> createState() => _CardEditorDialogState();
}

class _CardEditorDialogState extends State<_CardEditorDialog> {
  late final TextEditingController _front =
      TextEditingController(text: widget.initialFront ?? '');
  late final TextEditingController _back =
      TextEditingController(text: widget.initialBack ?? '');
  bool _showError = false;

  bool get _isEditing => widget.initialFront != null || widget.initialBack != null;

  @override
  void dispose() {
    _front.dispose();
    _back.dispose();
    super.dispose();
  }

  void _submit() {
    final front = _front.text.trim();
    final back = _back.text.trim();
    if (front.isEmpty && back.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    Navigator.of(context).pop(
      CardEditorResult(
        front: front.isEmpty ? null : front,
        back: back.isEmpty ? null : back,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Modifier la carte' : 'Nouvelle carte'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _front,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Recto (question)'),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _back,
            decoration: const InputDecoration(labelText: 'Verso (réponse)'),
          ),
          if (_showError)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Renseignez au moins une face.',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
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
