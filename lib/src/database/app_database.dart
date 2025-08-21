import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';

import 'daos/quran_dao.dart';
import 'migrations/migrations.dart';
import 'tables/quran/chapters.dart';
import 'tables/quran/converters.dart';
import 'tables/quran/hizbs.dart';
import 'tables/quran/juzs.dart';
import 'tables/quran/rukus.dart';
import 'tables/quran/sajdahs.dart';
import 'tables/quran/words.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Words, Chapters, Hizbs, Juzs, Rukus, Sajdahs, AyahMetas],
  daos: [QuranDao, AyahMetaDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 👇 IMPORTANT: Match this with the schema version of prebuilt.db
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => buildMigrationStrategy(this);
}

// Handles async DB init (copying prebuilt.db if needed)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'app.db');
    final file = File(dbPath);

    if (!await file.exists()) {
      // First launch → copy prebuilt DB from assets
      final data = await rootBundle.load('assets/db/prebuilt.db');
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await file.writeAsBytes(bytes, flush: true);
    }

    // Open DB on a background isolate (non-blocking)
    return NativeDatabase.createInBackground(file);
  });
}
