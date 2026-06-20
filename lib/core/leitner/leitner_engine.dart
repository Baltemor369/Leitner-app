/// Moteur de la méthode de Leitner — logique pure, sans dépendance UI ni I/O.
///
/// Cette logique est volontairement isolée pour être couverte par des tests
/// unitaires exhaustifs (cf. §7.2 du cahier des charges).
library;

/// Nombre de boîtes du système de Leitner (cf. EF-7).
const int kBoxCount = 5;

/// Intervalle de révision (en jours) appliqué après une réussite, indexé par
/// boîte. `boxIntervalDays[box]` donne le délai pour une carte arrivant dans
/// la boîte [box] (1..5).
///
/// Schéma retenu pour le MVP : J+1 / +3 / +7 / +14 / +30 (cf. EF-7).
const Map<int, int> boxIntervalDays = {
  1: 1,
  2: 3,
  3: 7,
  4: 14,
  5: 30,
};

/// Résultat du calcul de progression d'une carte après une révision.
class ReviewOutcome {
  const ReviewOutcome({required this.newBox, required this.nextReviewDate});

  /// Nouvelle boîte de la carte (1..[kBoxCount]).
  final int newBox;

  /// Date de la prochaine révision.
  final DateTime nextReviewDate;
}

/// Applique la règle de Leitner à une carte révisée.
///
/// - [currentBox] : boîte actuelle de la carte (1..[kBoxCount]).
/// - [wasCorrect] : `true` si l'apprenant a indiqué « su », `false` sinon.
/// - [today] : date de référence (par défaut, aujourd'hui).
///
/// Règles (cf. EF-9, EF-10, EF-11) :
/// - « su »  → la carte monte d'une boîte (plafonnée à [kBoxCount]) ;
/// - « pas su » → la carte retourne en boîte 1 ;
/// - la prochaine date = jour de référence + intervalle de la nouvelle boîte.
ReviewOutcome applyReview({
  required int currentBox,
  required bool wasCorrect,
  DateTime? today,
}) {
  if (currentBox < 1 || currentBox > kBoxCount) {
    throw RangeError.range(currentBox, 1, kBoxCount, 'currentBox');
  }

  final reference = _dateOnly(today ?? DateTime.now());
  final newBox = wasCorrect ? (currentBox + 1).clamp(1, kBoxCount) : 1;
  final nextReviewDate = _addDays(reference, boxIntervalDays[newBox]!);

  return ReviewOutcome(newBox: newBox, nextReviewDate: nextReviewDate);
}

/// Indique si une carte est « due » : sa prochaine révision est aujourd'hui ou
/// dans le passé (cf. EF-8).
bool isDue({required DateTime nextReviewDate, DateTime? today}) {
  final reference = _dateOnly(today ?? DateTime.now());
  final due = _dateOnly(nextReviewDate);
  return !due.isAfter(reference);
}

/// Normalise une date à minuit (ignore l'heure) pour des comparaisons fiables.
DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Ajoute [days] jours **calendaires** à [date].
///
/// On passe par le constructeur `DateTime` (qui normalise un jour qui déborde
/// du mois) plutôt que par `Duration(days:)`, afin d'être insensible aux
/// changements d'heure (DST) : `Duration` ajoute une durée absolue de 24 h,
/// ce qui peut décaler la date d'un jour lors des transitions horaires.
DateTime _addDays(DateTime date, int days) =>
    DateTime(date.year, date.month, date.day + days);
