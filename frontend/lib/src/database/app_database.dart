import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/src/database/daos/quran_listing_dao.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';
import 'package:tajweed_ai/src/database/tables/quran/page_lines.dart';

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
  tables: [Words, Chapters, Hizbs, Juzs, Rukus, Sajdahs, AyahMetas, PageLines],
  daos: [QuranListingDao, QuranPageDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 👇 Drift's structural schema version (table shapes). Changes to the *content*
  // of assets/db/prebuilt.db are handled by [_prebuiltDbVersion] instead.
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => buildMigrationStrategy(this);
}

/// Content version of `assets/db/prebuilt.db`. **Bump this whenever the asset
/// changes** — devices whose copy predates the bump re-copy it on next launch.
///
/// Needed because the on-device `app.db` is a copy made at first launch and is
/// never touched again: installs older than the `words.glyph_text` / `words.text`
/// split still had a single `text` column holding font glyph codes, so anything
/// reading plain Arabic (copy ayah, recitation matching) got glyphs instead.
const int _prebuiltDbVersion = 1;

// Handles async DB init (copying prebuilt.db when missing or outdated)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.db'));
    final stampFile = File(p.join(dir.path, 'app.db.version'));

    if (!await file.exists() ||
        await _readStamp(stampFile) != _prebuiltDbVersion) {
      await _installPrebuiltDb(file, stampFile);
    }

    // Open DB on a background isolate (non-blocking)
    return NativeDatabase.createInBackground(file);
  });
}

/// Content version of the DB currently installed, or `null` when the stamp is
/// missing or unreadable (treated as outdated).
Future<int?> _readStamp(File stampFile) async {
  try {
    return int.tryParse((await stampFile.readAsString()).trim());
  } catch (_) {
    return null;
  }
}

/// Copies the prebuilt asset over [file], then stamps [stampFile].
///
/// Runs before the database is opened, so there is no live handle to the file.
/// The asset is staged in a `.tmp` sibling and renamed, so a kill mid-write
/// leaves the previous `app.db` intact; the stamp is written last, so any
/// interruption simply re-runs the install on the next launch.
Future<void> _installPrebuiltDb(File file, File stampFile) async {
  final tmp = File('${file.path}.tmp');
  final data = await rootBundle.load('assets/db/prebuilt.db');
  await tmp.writeAsBytes(
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    flush: true,
  );

  // Drop journals left by the outgoing DB — SQLite would otherwise replay them
  // into the fresh file and corrupt it.
  for (final suffix in ['-wal', '-shm', '-journal']) {
    final sidecar = File('${file.path}$suffix');
    if (await sidecar.exists()) await sidecar.delete();
  }

  await tmp.rename(file.path);
  await stampFile.writeAsString('$_prebuiltDbVersion', flush: true);
  await _purgeDbDerivedCaches();
}

/// Drops the persisted caches built from the previous DB. Only DB-derived keys
/// are removed — SharedPreferences also holds locale, theme and reciter
/// preferences, which must survive the refresh.
///
/// Keys mirror `PageCache._kPageKey` and `ListingCache._kKey`.
Future<void> _purgeDbDerivedCaches() async {
  final prefs = await SharedPreferences.getInstance();
  for (final key in prefs.getKeys().toList()) {
    if (key.startsWith('page:') || key == 'listing_data_v3') {
      await prefs.remove(key);
    }
  }
}
