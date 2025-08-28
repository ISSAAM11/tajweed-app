import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

import '../app_database.dart';
import '../tables/quran/chapters.dart';
import '../tables/quran/words.dart';

part 'quran_dao.g.dart';

@DriftAccessor(tables: [AyahMetas, Words, Chapters])
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(super.db);

  /// Lookup meta for a given ayah
  Future<AyahMetaRow?> getAyahMetaByKey(VerseKey key) {
    return (select(ayahMetas)
          ..where((a) => a.surah.equals(key.surah) & a.ayah.equals(key.ayah)))
        .getSingleOrNull();
  }

  /// Get ayat of a page with words
  Future<List<(AyahMetaRow, List<WordRow>)>> getPageAyat(int pageNo) async {
    final ayat = await (select(
      ayahMetas,
    )..where((a) => a.pageNo.equals(pageNo))).get();

    final result = <(AyahMetaRow, List<WordRow>)>[];
    for (final ayah in ayat) {
      final wordsResult =
          await (select(words)..where(
                (w) => w.surah.equals(ayah.surah) & w.ayah.equals(ayah.ayah),
              ))
              .get();
      result.add((ayah, wordsResult));
    }
    return result;
  }

  /// Given verse key, get containing partition for a mode
  Future<int?> getPartitionForAyah(
    PartitionMode mode,
    VerseKey verseKey,
  ) async {
    final meta = await getAyahMetaByKey(verseKey);
    if (meta == null) return null;
    switch (mode) {
      case PartitionMode.surah:
        return meta.surah;
      case PartitionMode.juz:
        return meta.juzNo;
      case PartitionMode.hizb:
        return meta.hizbNo;
      case PartitionMode.ruku:
        return meta.rukuNo;
      case PartitionMode.page:
        return meta.pageNo;
    }
  }

  /// Stream: page metadata for sticky header (first ayah on page)
  Stream<AyahMetaRow?> watchPageMeta(int pageNo) {
    final q =
        (select(ayahMetas)
              ..where((a) => a.pageNo.equals(pageNo))
              ..orderBy([(a) => OrderingTerm.asc(a.globalIndex)])
              ..limit(1))
            .watchSingleOrNull();
    return q;
  }

  /// Page ayat ordered by mushaf flow
  Future<List<AyahMetaRow>> getPageAyatMetas(int pageNo) {
    return (select(ayahMetas)
          ..where((a) => a.pageNo.equals(pageNo))
          ..orderBy([(a) => OrderingTerm.asc(a.globalIndex)]))
        .get();
  }

  Future<List<WordRow>> getWordsForAyat(List<VerseKey> ayat) {
    if (ayat.isEmpty) return Future.value([]);

    final expression = ayat
        .map((a) => words.surah.equals(a.surah) & words.ayah.equals(a.ayah))
        .reduce((lhs, rhs) => lhs | rhs);

    return (select(words)..where((tbl) => expression)).get();
  }

  Future<({List<int> pages, int? totalPartitions})> getPagesForPartition({
    required PartitionMode mode,
    required int partitionNo,
    HizbFraction? fraction,
    bool getTotal = false,
  }) async {
    // Helper to resolve the right column
    Column<int> columnForMode(PartitionMode mode) {
      switch (mode) {
        case PartitionMode.page:
          return ayahMetas.pageNo;
        case PartitionMode.juz:
          return ayahMetas.juzNo;
        case PartitionMode.hizb:
          return ayahMetas.hizbNo;
        case PartitionMode.ruku:
          return ayahMetas.rukuNo;
        case PartitionMode.surah:
          return ayahMetas.surah;
      }
    }

    final column = columnForMode(mode);

    // Special case: Page mode → trivial
    if (mode == PartitionMode.page) {
      int? total;
      if (getTotal) {
        total = await (selectOnly(
          ayahMetas,
          distinct: true,
        )..addColumns([ayahMetas.pageNo])).get().then((rows) => rows.length);
      }
      return (pages: [partitionNo], totalPartitions: total);
    }

    // Query pages for given partition
    final q = selectOnly(ayahMetas, distinct: true)
      ..addColumns([ayahMetas.pageNo])
      ..where(column.equals(partitionNo));

    if (mode == PartitionMode.hizb && fraction != null) {
      q.where(ayahMetas.hizbFraction.equalsValue(fraction));
    }

    final pages = await q.map((row) => row.read<int>(ayahMetas.pageNo)).get();

    // Compute totalPartitions only if requested
    int? total;
    if (getTotal) {
      total = await (selectOnly(
        ayahMetas,
        distinct: true,
      )..addColumns([column])).get().then((rows) => rows.length);
    }

    return (pages: pages.whereType<int>().toList(), totalPartitions: total);
  }
}
