import 'package:flutter/material.dart';

/// Demande une confirmation à l'utilisateur. Renvoie `true` si confirmé.
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Supprimer',
  String cancelLabel = 'Annuler',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Exécute une opération asynchrone en interceptant les erreurs : en cas
/// d'échec, affiche un message discret (SnackBar) plutôt que de laisser une
/// exception non gérée. Renvoie `true` si l'opération a réussi.
///
/// Le `context.mounted` est vérifié après l'`await` pour ne jamais toucher un
/// widget démonté.
Future<bool> runGuarded(
  BuildContext context,
  Future<void> Function() action, {
  String errorMessage = 'Une erreur est survenue. Réessayez.',
}) async {
  try {
    await action();
    return true;
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
    return false;
  }
}
