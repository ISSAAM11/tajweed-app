import 'package:tajweed_ai/src/features/home/quran/audio/database/cheikh_registry/cheikh_registry_database.dart';
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
}
