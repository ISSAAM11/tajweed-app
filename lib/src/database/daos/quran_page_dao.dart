import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/page_models.dart';

import '../app_database.dart';
import '../tables/quran/chapters.dart';
import '../tables/quran/words.dart';

part 'generated/quran_page_dao.g.dart';

@DriftAccessor(tables: [AyahMetas, Words, Chapters])
class QuranPageDao extends DatabaseAccessor<AppDatabase>
    with _$QuranPageDaoMixin {
  QuranPageDao(super.db);

  // ****************** Validated
  Future<List<WordRow>> getWordsForAyat(List<VerseKey> ayat) {
    if (ayat.isEmpty) return Future.value([]);

    final expression = ayat
        .map((a) => words.surah.equals(a.surah) & words.ayah.equals(a.ayah))
        .reduce((lhs, rhs) => lhs | rhs);

    return (select(words)..where((tbl) => expression)).get();
  }

  /// Returns map: surahId -> ordered list of pages in that surah
  Future<Map<int, List<int>>> buildPagesBySurah() async {
    final query =
        await (select(ayahMetas)..orderBy([
              (t) => OrderingTerm(expression: t.surah),
              (t) => OrderingTerm(expression: t.pageNo),
            ]))
            .get();

    final map = <int, Set<int>>{};
    for (final row in query) {
      map.putIfAbsent(row.surah, () => <int>{}).add(row.pageNo);
    }

    // Convert sets to sorted lists
    return map.map((k, v) => MapEntry(k, v.toList()..sort()));
  }

  /// Returns map: juzNo -> ordered list of pages in that juz
  Future<Map<int, List<int>>> buildPagesByJuz() async {
    final query =
        await (select(ayahMetas)..orderBy([
              (t) => OrderingTerm(expression: t.juzNo),
              (t) => OrderingTerm(expression: t.pageNo),
            ]))
            .get();

    final map = <int, Set<int>>{};
    for (final row in query) {
      map.putIfAbsent(row.juzNo, () => <int>{}).add(row.pageNo);
    }

    return map.map((k, v) => MapEntry(k, v.toList()..sort()));
  }

  /// Returns map: hizbNo -> ordered list of pages in that hizb
  Future<Map<int, List<int>>> buildPagesByHizb() async {
    final query =
        await (select(ayahMetas)..orderBy([
              (t) => OrderingTerm(expression: t.hizbNo),
              (t) => OrderingTerm(expression: t.pageNo),
            ]))
            .get();

    final map = <int, Set<int>>{};
    for (final row in query) {
      map.putIfAbsent(row.hizbNo, () => <int>{}).add(row.pageNo);
    }

    return map.map((k, v) => MapEntry(k, v.toList()..sort()));
  }

  /// Returns map: rukuNo -> ordered list of pages in that ruku
  Future<Map<int, List<int>>> buildPagesByRuku() async {
    final query =
        await (select(ayahMetas)..orderBy([
              (t) => OrderingTerm(expression: t.rukuNo),
              (t) => OrderingTerm(expression: t.pageNo),
            ]))
            .get();

    final map = <int, Set<int>>{};
    for (final row in query) {
      map.putIfAbsent(row.rukuNo, () => <int>{}).add(row.pageNo);
    }

    return map.map((k, v) => MapEntry(k, v.toList()..sort()));
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

  Future<ChapterHeaderDto> getChapterHeader(int surahId) async {
    final row = await (select(
      chapters,
    )..where((c) => c.id.equals(surahId))).getSingle();
    return ChapterHeaderDto.fromChapterRow(row);
  }

  Future<int> getPageForVerse(VerseKey key) async {
    final ayahMeta =
        await (select(ayahMetas)..where(
              (a) => a.surah.equals(key.surah) & a.ayah.equals(key.ayah),
            ))
            .getSingle();
    return ayahMeta.pageNo;
  }

  /// Page ayat ordered by mushaf flow
  Future<List<AyahMetaRow>> getPageAyatMetas(int pageNo) {
    return (select(ayahMetas)
          ..where((a) => a.pageNo.equals(pageNo))
          ..orderBy([(a) => OrderingTerm.asc(a.globalIndex)]))
        .get();
  }
}
