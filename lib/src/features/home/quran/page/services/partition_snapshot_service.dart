import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

class PartitionSnapshotService {
  final QuranPageDao dao;

  PartitionSnapshotService(this.dao);

  PartitionSnapshot? _snapshot;

  PartitionSnapshot get snapshot {
    if (_snapshot == null) {
      throw StateError("PartitionSnapshot not loaded yet. Call load() first.");
    }
    return _snapshot!;
  }

  Future<PartitionSnapshot> load() async {
    if (_snapshot != null) return _snapshot!;

    final pagesBySurah = await dao.buildPagesBySurah();
    final pagesByJuz = await dao.buildPagesByJuz();
    final pagesByHizb = await dao.buildPagesByHizb();
    final pagesByRuku = await dao.buildPagesByRuku();
    final pages = await dao.buildPages();

    // reverse maps
    final pageToSurah = _reverse(pagesBySurah);
    final pageToJuz = _reverse(pagesByJuz);
    final pageToHizb = _reverse(pagesByHizb);
    final pageToRuku = _reverse(pagesByRuku);

    _snapshot = PartitionSnapshot(
      totalSurahs: pagesBySurah.keys.length,
      totalJuz: pagesByJuz.keys.length,
      totalHizb: pagesByHizb.keys.length,
      totalRuku: pagesByRuku.keys.length,
      totalPage: pages,
      pagesBySurah: pagesBySurah,
      pagesByJuz: pagesByJuz,
      pagesByHizb: pagesByHizb,
      pagesByRuku: pagesByRuku,
      pageToSurah: pageToSurah,
      pageToJuz: pageToJuz,
      pageToHizb: pageToHizb,
      pageToRuku: pageToRuku,
    );
    return _snapshot!;
  }

  Map<int, int> _reverse(Map<int, List<int>> source) {
    final map = <int, int>{};
    source.forEach((partitionId, pages) {
      for (final p in pages) {
        map[p] = partitionId;
      }
    });
    return map;
  }

  int getTotalByMode(PartitionSnapshot snapshot, PartitionMode mode) {
    switch (mode) {
      case PartitionMode.surah:
        return snapshot.totalSurahs;
      case PartitionMode.juz:
        return snapshot.totalJuz;
      case PartitionMode.hizb:
        return snapshot.totalHizb;
      case PartitionMode.ruku:
        return snapshot.totalRuku;
      case PartitionMode.page:
        return snapshot.totalPage;
    }
  }
}
