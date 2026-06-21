import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leitner/core/database/app_database.dart';
import 'package:leitner/features/cards/card_repository.dart';
import 'package:leitner/features/decks/deck_repository.dart';
import 'package:leitner/features/review/review_repository.dart';

void main() {
  late AppDatabase db;
  late DeckRepository decks;
  late CardRepository cards;
  late ReviewRepository review;
  final today = DateTime(2026, 6, 21);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    decks = DeckRepository(db);
    cards = CardRepository(db);
    review = ReviewRepository(db);
  });

  tearDown(() async => db.close());

  group('DeckRepository', () {
    test('crée un deck et nettoie le nom', () async {
      final id = await decks.createDeck('  Japonais  ');
      final summaries = await decks.getDeckSummaries(today: today);
      expect(summaries, hasLength(1));
      expect(summaries.single.deck.id, id);
      expect(summaries.single.deck.name, 'Japonais');
    });

    test('refuse un nom vide', () {
      expect(() => decks.createDeck('   '), throwsArgumentError);
    });

    test('renomme un deck', () async {
      final id = await decks.createDeck('Ancien');
      await decks.renameDeck(id, 'Nouveau');
      final summaries = await decks.getDeckSummaries(today: today);
      expect(summaries.single.deck.name, 'Nouveau');
    });

    test('compte les cartes totales et dues', () async {
      final deckId = await decks.createDeck('Bio');
      await cards.createCard(deckId: deckId, front: 'A', back: '1', today: today);
      final c2 =
          await cards.createCard(deckId: deckId, front: 'B', back: '2', today: today);

      // On pousse la 2e carte dans le futur : elle ne sera plus due aujourd'hui.
      await review.reviewCard(cardId: c2, wasCorrect: true, today: today);

      final summary = (await decks.getDeckSummaries(today: today)).single;
      expect(summary.cardCount, 2);
      expect(summary.dueCount, 1);
    });

    test('supprime un deck en cascade et renvoie les images à effacer',
        () async {
      final deckId = await decks.createDeck('Plantes');
      await cards.createCard(
        deckId: deckId,
        front: 'Ortie',
        frontImagePath: '/img/ortie.jpg',
        backImagePath: '/img/ortie_back.jpg',
        today: today,
      );

      final removedImages = await decks.deleteDeck(deckId);

      expect(removedImages, containsAll(['/img/ortie.jpg', '/img/ortie_back.jpg']));
      expect(await decks.getDeckSummaries(today: today), isEmpty);
      expect(await cards.getCardsForDeck(deckId), isEmpty);
    });

    test('la cascade supprime aussi les logs de révision', () async {
      final deckId = await decks.createDeck('Deck');
      final cardId =
          await cards.createCard(deckId: deckId, front: 'Q', back: 'R', today: today);
      await review.reviewCard(cardId: cardId, wasCorrect: true, today: today);
      expect(await db.select(db.reviewLogs).get(), isNotEmpty);

      await decks.deleteDeck(deckId);

      expect(await db.select(db.reviewLogs).get(), isEmpty);
    });

    test('renommer un deck inexistant lève une erreur', () {
      expect(() => decks.renameDeck(999, 'X'), throwsStateError);
    });
  });

  group('CardRepository', () {
    late int deckId;
    setUp(() async => deckId = await decks.createDeck('Deck'));

    test('crée une carte en boîte 1, due le jour même', () async {
      await cards.createCard(deckId: deckId, front: 'Q', back: 'R', today: today);
      final card = (await cards.getCardsForDeck(deckId)).single;
      expect(card.box, 1);
      expect(card.nextReviewDate, today);
      expect(await cards.getDueCards(today: today), hasLength(1));
    });

    test('accepte une carte image seule (sans texte)', () async {
      await cards.createCard(
          deckId: deckId, frontImagePath: '/img/x.jpg', today: today);
      final card = (await cards.getCardsForDeck(deckId)).single;
      expect(card.front, isNull);
      expect(card.frontImagePath, '/img/x.jpg');
    });

    test('refuse une carte entièrement vide', () {
      expect(
        () => cards.createCard(deckId: deckId, front: '  ', today: today),
        throwsArgumentError,
      );
    });

    test('éditer le contenu ne réinitialise pas la progression', () async {
      await cards.createCard(deckId: deckId, front: 'Q', back: 'R', today: today);
      var card = (await cards.getCardsForDeck(deckId)).single;
      await review.reviewCard(cardId: card.id, wasCorrect: true, today: today);

      await cards.updateCardContent(
          id: card.id, front: const Value('Q2'), back: const Value('R2'));

      card = (await cards.getCardsForDeck(deckId)).single;
      expect(card.front, 'Q2');
      expect(card.box, 2); // progression conservée
      expect(card.nextReviewDate, today.add(const Duration(days: 3)));
    });

    test('éditer une seule face ne touche pas les autres champs', () async {
      await cards.createCard(deckId: deckId, front: 'Q', back: 'R', today: today);
      final card = (await cards.getCardsForDeck(deckId)).single;

      // On ne passe que le recto : le verso doit rester intact.
      await cards.updateCardContent(id: card.id, front: const Value('Q2'));

      final updated = (await cards.getCardsForDeck(deckId)).single;
      expect(updated.front, 'Q2');
      expect(updated.back, 'R');
    });

    test('remplacer une image renvoie l\'ancien fichier à effacer', () async {
      await cards.createCard(
          deckId: deckId, frontImagePath: '/img/old.jpg', today: today);
      final card = (await cards.getCardsForDeck(deckId)).single;

      final removed = await cards.updateCardContent(
          id: card.id, frontImagePath: const Value('/img/new.jpg'));

      expect(removed, ['/img/old.jpg']);
      final updated = (await cards.getCardsForDeck(deckId)).single;
      expect(updated.frontImagePath, '/img/new.jpg');
    });

    test('refuse un chemin d\'image contenant ".."', () {
      expect(
        () => cards.createCard(
            deckId: deckId, frontImagePath: '../../secret.jpg', today: today),
        throwsArgumentError,
      );
    });

    test('éditer une carte inexistante lève une erreur', () {
      expect(
        () => cards.updateCardContent(id: 999, front: const Value('X')),
        throwsStateError,
      );
    });

    test('supprimer une carte renvoie ses images', () async {
      await cards.createCard(
        deckId: deckId,
        back: 'R',
        backImagePath: '/img/y.jpg',
        today: today,
      );
      final card = (await cards.getCardsForDeck(deckId)).single;
      final removed = await cards.deleteCard(card.id);
      expect(removed, ['/img/y.jpg']);
      expect(await cards.getCardsForDeck(deckId), isEmpty);
    });
  });

  group('ReviewRepository', () {
    late int cardId;
    setUp(() async {
      final deckId = await decks.createDeck('Deck');
      cardId =
          await cards.createCard(deckId: deckId, front: 'Q', back: 'R', today: today);
    });

    test('« su » fait monter la carte et la replanifie hors du jour', () async {
      final outcome =
          await review.reviewCard(cardId: cardId, wasCorrect: true, today: today);
      expect(outcome.newBox, 2);

      final updated = (await cards.getDueCards(today: today));
      expect(updated, isEmpty); // plus due aujourd'hui
      expect(await review.countDueCards(today: today), 0);
    });

    test('« pas su » garde la carte due (boîte 1, +1 jour)', () async {
      final outcome =
          await review.reviewCard(cardId: cardId, wasCorrect: false, today: today);
      expect(outcome.newBox, 1);
      expect(await review.countDueCards(today: today), 0); // due demain
      expect(
        await review.countDueCards(
            today: today.add(const Duration(days: 1))),
        1,
      );
    });

    test('journalise la révision dans ReviewLogs', () async {
      await review.reviewCard(cardId: cardId, wasCorrect: true, today: today);
      final logs = await db.select(db.reviewLogs).get();
      expect(logs, hasLength(1));
      expect(logs.single.wasCorrect, isTrue);
      expect(logs.single.boxBefore, 1);
      expect(logs.single.boxAfter, 2);
    });
  });
}
