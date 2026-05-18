import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
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
    final pages = await dao.buildPages();

    // reverse maps
    final pageToSurah = _reverse(pagesBySurah);

    _snapshot = PartitionSnapshot(
      totalSurahs: pagesBySurah.keys.length,
      totalPage: pages,
      pagesBySurah: pagesBySurah,
      pageToSurah: pageToSurah,
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

  int getTotalByMode(PartitionSnapshot snapshot) {
    return snapshot.totalPage;
  }
}
