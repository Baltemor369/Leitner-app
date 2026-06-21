import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leitner/core/database/app_database.dart';
import 'package:leitner/core/providers.dart';
import 'package:leitner/features/decks/decks_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() async => db.close());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: DecksScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('crée un paquet depuis l\'écran d\'accueil', (tester) async {
    await pumpApp(tester);
    expect(find.text('Japonais'), findsNothing);

    await tester.tap(find.text('Nouveau paquet'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Japonais');
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    expect(find.text('Japonais'), findsOneWidget);
  });

  testWidgets('ajoute une carte dans un paquet', (tester) async {
    await pumpApp(tester);

    // Créer un paquet.
    await tester.tap(find.text('Nouveau paquet'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Bio');
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    // Ouvrir le paquet puis ajouter une carte.
    await tester.tap(find.text('Bio'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nouvelle carte'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Ortie');
    await tester.enterText(fields.at(1), 'Urtica dioica');
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    expect(find.text('Ortie'), findsOneWidget);
    expect(find.text('Urtica dioica'), findsOneWidget);
  });

  testWidgets('supprimer une carte demande confirmation (EF-6)',
      (tester) async {
    await pumpApp(tester);

    // Paquet + carte.
    await tester.tap(find.text('Nouveau paquet'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Bio');
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bio'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nouvelle carte'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Ortie');
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    // Ouvre le menu de la carte puis « Supprimer ».
    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Supprimer'));
    await tester.pumpAndSettle();

    // Une confirmation doit apparaître ; la carte est encore là.
    expect(find.text('Supprimer la carte ?'), findsOneWidget);
    expect(find.text('Ortie'), findsOneWidget);

    // Confirme la suppression.
    await tester.tap(find.text('Supprimer'));
    await tester.pumpAndSettle();
    expect(find.text('Ortie'), findsNothing);
  });
}
