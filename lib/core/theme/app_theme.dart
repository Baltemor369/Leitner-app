import 'package:flutter/material.dart';

/// Thèmes clair et sombre de l'application (EF-21).
///
/// Construits à partir d'une couleur de base unique pour une palette cohérente
/// (Material 3).
class AppTheme {
  AppTheme._();

  static const Color _seed = Color(0xFF3F6FB5);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: brightness,
      ),
    );
  }
}
