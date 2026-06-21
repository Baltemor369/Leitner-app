import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/decks/decks_screen.dart';

void main() {
  runApp(const ProviderScope(child: LeitnerApp()));
}

/// Racine de l'application Leitner.
class LeitnerApp extends StatelessWidget {
  const LeitnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leitner',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const DecksScreen(),
    );
  }
}
