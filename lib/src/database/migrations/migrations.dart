import 'package:drift/drift.dart';

import '../app_database.dart';
import 'quran_migrations.dart';

MigrationStrategy buildMigrationStrategy(AppDatabase db) {
  return MigrationStrategy(
    onCreate: (m) async {
      await m.createAll(); // initial tables
    },
    onUpgrade: (m, from, to) async {
      await migrateQuran(m: m, from: from, to: to, db: db);
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        // seeding handled later
      }
    },
  );
}
