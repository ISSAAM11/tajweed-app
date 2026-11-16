import 'package:tajweed_ai/src/features/home/quran/audio/database/cheikh_registry/cheikh_registry_database.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/datasource/reciter_catalog_model.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';

class CheikhRegistryDao {
  final CheikhRegistryDatabase _db;
  CheikhRegistryDao(this._db);

  Future<List<CheikhReciter>> getAllCheikhs() async {
    final rows = await _db.select(_db.cheikhListTable).get();
    return rows
        .map(
          (r) => CheikhReciter(
            id: r.id,
            name: r.nameSimple,
            nameArabic: r.nameArabic,
            dbAssetPath: r.dbAssetPath,
          ),
        )
        .toList();
  }

  /// Makes the local registry mirror the backend catalog: upserts every
  /// fetched reciter and drops local rows the backend no longer lists (e.g.
  /// stale entries copied from an older bundled seed). `dbAssetPath` becomes
  /// the reciter's remote timing-db URL, downloaded on demand by
  /// [AudioDatabaseRegistry] the same way ayah/surah MP3s already are.
  Future<List<CheikhReciter>> upsertReciters(
    List<RemoteReciter> remote,
  ) async {
    await _db.batch((batch) {
      batch.deleteWhere(
        _db.cheikhListTable,
        (t) => t.id.isNotIn([for (final r in remote) r.slug]),
      );
      batch.insertAllOnConflictUpdate(
        _db.cheikhListTable,
        [
          for (final r in remote)
            CheikhListTableCompanion.insert(
              id: r.slug,
              nameArabic: r.nameArabic,
              nameSimple: r.nameSimple,
              dbAssetPath: r.timingDbUrl,
            ),
        ],
      );
    });
    return getAllCheikhs();
  }
}
