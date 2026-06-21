import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Ouvre la base SQLite de l'application dans le répertoire de documents de
/// l'appareil. Réservé à l'exécution réelle (les tests utilisent une base en
/// mémoire, cf. `NativeDatabase.memory()`).
LazyDatabase openAppConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'leitner.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
