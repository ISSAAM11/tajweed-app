import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';

part 'ayah_meta_dao.g.dart';

@DriftAccessor(tables: [AyahMetas])
class AyahMetaDao extends DatabaseAccessor<AppDatabase>
    with _$AyahMetaDaoMixin {
  AyahMetaDao(super.db);

  /// Get ayah meta by surah and ayah number
  Future<AyahMetaRow?> getAyahMeta(int surah, int ayah) {
    return (select(ayahMetas)
          ..where((a) => a.surah.equals(surah) & a.ayah.equals(ayah)))
        .getSingleOrNull();
  }

  /// Get all meta for a surah
  Future<List<AyahMetaRow>> getSurahMeta(int surah) {
    return (select(ayahMetas)..where((a) => a.surah.equals(surah))).get();
  }

  /// Get all ayat on a specific page
  Future<List<AyahMetaRow>> getPage(int pageNo) {
    return (select(ayahMetas)..where((a) => a.pageNo.equals(pageNo))).get();
  }

  /// Get all ayat in a juz
  Future<List<AyahMetaRow>> getJuz(int juzNo) {
    return (select(ayahMetas)..where((a) => a.juzNo.equals(juzNo))).get();
  }

  /// Get all ayat in a hizb
  Future<List<AyahMetaRow>> getHizb(int hizbNo) {
    return (select(ayahMetas)..where((a) => a.hizbNo.equals(hizbNo))).get();
  }

  /// Get all ayat in a ruku
  Future<List<AyahMetaRow>> getRuku(int rukuNo) {
    return (select(ayahMetas)..where((a) => a.rukuNo.equals(rukuNo))).get();
  }

  /// Get ayah meta by global index
  Future<AyahMetaRow?> getByGlobalIndex(int globalIndex) {
    return (select(
      ayahMetas,
    )..where((a) => a.globalIndex.equals(globalIndex))).getSingleOrNull();
  }

  /// Get page number for a specific ayah
  Future<int?> getPageForAyah(int surah, int ayah) async {
    final meta = await getAyahMeta(surah, ayah);
    return meta?.pageNo;
  }
}
