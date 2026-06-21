/// Utilitaires de dates à granularité « jour », sûrs vis-à-vis des changements
/// d'heure (DST) : on reste dans le domaine calendaire (constructeur `DateTime`,
/// qui normalise un jour débordant du mois) plutôt que d'ajouter une `Duration`
/// absolue de 24 h, qui pourrait décaler la date d'un jour lors des transitions.
library;

/// Normalise une date à minuit (ignore l'heure) pour des comparaisons fiables.
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Ajoute [days] jours calendaires à [date].
DateTime addDays(DateTime date, int days) =>
    DateTime(date.year, date.month, date.day + days);

/// Représente une date au format ISO « yyyy-MM-dd » (sans heure).
///
/// C'est ce format qui est persisté pour les dates de révision : la comparaison
/// lexicographique de ces chaînes équivaut à l'ordre chronologique, ce qui rend
/// la logique « due » totalement indépendante du fuseau horaire et du DST.
String isoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';
