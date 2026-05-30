import 'package:drift/drift.dart';

import '../app_database.dart';

Future<void> migrateQuran({
  required Migrator m,
  required int from,
  required int to,
  required AppDatabase db,
}) async {
  // // Example: schema v2 -> v3: add a 'translation' column to verses
  // if (from < 3 && to >= 3) {
  //   await m.addColumn(db.verses, db.verses.translation);
  // }
}
