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
  Future<AyahMetaRow?> getAyahMeta(int globalIndex) {
    return (select(
      ayahMetas,
    )..where((a) => a.globalIndex.equals(globalIndex))).getSingleOrNull();
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

  /// Given globalIndex, get containing partition for a mode
  Future<int?> getPartitionForAyah(PartitionMode mode, int globalIndex) async {
    final meta = await getAyahMeta(globalIndex);
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

  Future<List<WordRow>> getWordsForAyat(List<(int, int)> ayat) {
    if (ayat.isEmpty) return Future.value([]);

    final expression = ayat
        .map((a) => words.surah.equals(a.$1) & words.ayah.equals(a.$2))
        .reduce((lhs, rhs) => lhs | rhs);

    return (select(words)..where((tbl) => expression)).get();
  }

  Future<List<int>> getPagesForPartition(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
  }) async {
    switch (mode) {
      case PartitionMode.page:
        return [partitionNo];

      case PartitionMode.juz:
        final rows =
            await (selectOnly(ayahMetas, distinct: true)
                  ..addColumns([ayahMetas.pageNo])
                  ..where(ayahMetas.juzNo.equals(partitionNo)))
                .map((row) => row.read<int>(ayahMetas.pageNo))
                .get();
        return rows.whereType<int>().toList(); // remove nulls

      case PartitionMode.hizb:
        final q = selectOnly(ayahMetas, distinct: true)
          ..addColumns([ayahMetas.pageNo])
          ..where(ayahMetas.hizbNo.equals(partitionNo));
        if (fraction != null) {
          q.where(ayahMetas.hizbFraction.equalsValue(fraction));
        }
        final rows = await q
            .map((row) => row.read<int>(ayahMetas.pageNo))
            .get();
        return rows.whereType<int>().toList();

      case PartitionMode.ruku:
        final rows =
            await (selectOnly(ayahMetas, distinct: true)
                  ..addColumns([ayahMetas.pageNo])
                  ..where(ayahMetas.rukuNo.equals(partitionNo)))
                .map((row) => row.read<int>(ayahMetas.pageNo))
                .get();
        return rows.whereType<int>().toList();

      case PartitionMode.surah:
        final rows =
            await (selectOnly(ayahMetas, distinct: true)
                  ..addColumns([ayahMetas.pageNo])
                  ..where(ayahMetas.surah.equals(partitionNo)))
                .map((row) => row.read<int>(ayahMetas.pageNo))
                .get();
        return rows.whereType<int>().toList();
    }
  }

  Stream<List<int>> watchPagesForPartition(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
  }) {
    final query = selectOnly(ayahMetas, distinct: true)
      ..addColumns([ayahMetas.pageNo]);
    // Filter by mode
    switch (mode) {
      case PartitionMode.page:
        // page mode: only the given page
        return Stream.value([partitionNo]);

      case PartitionMode.juz:
        query.where(ayahMetas.juzNo.equals(partitionNo));
        break;

      case PartitionMode.hizb:
        query.where(ayahMetas.hizbNo.equals(partitionNo));
        if (fraction != null) {
          query.where(ayahMetas.hizbFraction.equalsValue(fraction));
        }
        break;

      case PartitionMode.ruku:
        query.where(ayahMetas.rukuNo.equals(partitionNo));
        break;

      case PartitionMode.surah:
        query.where(ayahMetas.surah.equals(partitionNo));
        break;
    }

    return query.watch().map(
      (rows) => rows
          .map((row) => row.read<int>(ayahMetas.pageNo))
          .whereType<int>()
          .toList(),
    );
  }
}
