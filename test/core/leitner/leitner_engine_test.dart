import 'package:flutter_test/flutter_test.dart';
import 'package:leitner/core/leitner/leitner_engine.dart';

void main() {
  final today = DateTime(2026, 6, 20);

  group('applyReview', () {
    test('« su » fait monter la carte d\'une boîte et replanifie', () {
      final outcome =
          applyReview(currentBox: 1, wasCorrect: true, today: today);
      expect(outcome.newBox, 2);
      expect(outcome.nextReviewDate, today.add(const Duration(days: 3)));
    });

    test('« pas su » renvoie la carte en boîte 1 (+1 jour)', () {
      final outcome =
          applyReview(currentBox: 4, wasCorrect: false, today: today);
      expect(outcome.newBox, 1);
      expect(outcome.nextReviewDate, today.add(const Duration(days: 1)));
    });

    test('une carte en boîte 5 réussie reste en boîte 5 (+30 jours)', () {
      final outcome =
          applyReview(currentBox: 5, wasCorrect: true, today: today);
      expect(outcome.newBox, 5);
      expect(outcome.nextReviewDate, today.add(const Duration(days: 30)));
    });

    test('respecte le schéma d\'intervalles J+1/+3/+7/+14/+30', () {
      expect(boxIntervalDays, {1: 1, 2: 3, 3: 7, 4: 14, 5: 30});
    });

    test('rejette une boîte hors bornes (validation active en release)', () {
      expect(() => applyReview(currentBox: 0, wasCorrect: true, today: today),
          throwsRangeError);
      expect(() => applyReview(currentBox: 6, wasCorrect: false, today: today),
          throwsRangeError);
    });
  });

  group('isDue', () {
    test('carte due si la date de révision est passée ou aujourd\'hui', () {
      expect(isDue(nextReviewDate: today, today: today), isTrue);
      expect(
          isDue(
              nextReviewDate: today.subtract(const Duration(days: 1)),
              today: today),
          isTrue);
    });

    test('carte non due si la date de révision est dans le futur', () {
      expect(
          isDue(
              nextReviewDate: today.add(const Duration(days: 1)), today: today),
          isFalse);
    });
  });
}
