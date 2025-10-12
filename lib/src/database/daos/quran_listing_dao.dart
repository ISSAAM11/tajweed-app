import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';
import 'package:tajweed_ai/src/database/tables/quran/chapters.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

import '../app_database.dart';
import '../tables/quran/words.dart';

part 'generated/quran_listing_dao.g.dart';

@DriftAccessor(tables: [AyahMetas, Words, Chapters])
class QuranListingDao extends DatabaseAccessor<AppDatabase>
    with _$QuranListingDaoMixin {
  QuranListingDao(super.db);

  Future<List<ChapterRow>> getChapters() async {
    return select(chapters).get();
  }

  /// Pages
  Future<List<PageItem>> getPagesWithFirstAyah() async {
    final rows = await customSelect(
      '''
        SELECT a.page_no, a.surah, a.ayah, w.text
        FROM ayah_metas a
        JOIN words w ON w.surah = a.surah AND w.ayah = a.ayah
        INNER JOIN (
          SELECT page_no, MIN(global_index) AS firstIndex
          FROM ayah_metas
          GROUP BY page_no
        ) b ON a.global_index = b.firstIndex
        ORDER BY a.page_no, w.word;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();

    final grouped = <int, List<Map<String, dynamic>>>{};

    for (final row in rows) {
      final pageNo = row.read<int>('page_no');
      grouped.putIfAbsent(pageNo, () => []).add(row.data);
    }

    return grouped.entries.map((entry) {
      final first = entry.value.first;
      return PageItem(
        pageNumber: entry.key,
        verseKey: VerseKey(first['surah'] as int, first['ayah'] as int),
        ayahWords: entry.value.map((r) => r['text'] as String).toList(),
      );
    }).toList();
  }

  /// Juz
  Future<List<JuzItem>> getJuzsWithFirstAyah() async {
    final rows = await customSelect(
      '''
        SELECT a.juz_no, a.surah, a.ayah, w.text
        FROM ayah_metas a
        JOIN words w ON w.surah = a.surah AND w.ayah = a.ayah
        INNER JOIN (
          SELECT juz_no, MIN(global_index) AS firstIndex
          FROM ayah_metas
          GROUP BY juz_no
        ) b ON a.global_index = b.firstIndex
        ORDER BY a.juz_no, w.word;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();

    final grouped = <int, List<Map<String, dynamic>>>{};

    for (final row in rows) {
      final juzNo = row.read<int>('juz_no');
      grouped.putIfAbsent(juzNo, () => []).add(row.data);
    }

    return grouped.entries.map((entry) {
      final first = entry.value.first;
      return JuzItem(
        juzNumber: entry.key,
        verseKey: VerseKey(first['surah'] as int, first['ayah'] as int),
        ayahWords: entry.value.map((r) => r['text'] as String).toList(),
      );
    }).toList();
  }

  /// Rukus
  Future<List<RukuItem>> getRukusWithFirstAyah() async {
    final rows = await customSelect(
      '''
        SELECT a.ruku_no, a.surah, a.ayah, w.text
        FROM ayah_metas a
        JOIN words w ON w.surah = a.surah AND w.ayah = a.ayah
        INNER JOIN (
          SELECT ruku_no, MIN(global_index) AS firstIndex
          FROM ayah_metas
          GROUP BY ruku_no
        ) b ON a.global_index = b.firstIndex
        ORDER BY a.ruku_no, w.word;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();

    final grouped = <int, List<Map<String, dynamic>>>{};

    for (final row in rows) {
      final rukuNo = row.read<int>('ruku_no');
      grouped.putIfAbsent(rukuNo, () => []).add(row.data);
    }

    return grouped.entries.map((entry) {
      final first = entry.value.first;
      return RukuItem(
        rukuNumber: entry.key,
        verseKey: VerseKey(first['surah'] as int, first['ayah'] as int),
        ayahWords: entry.value.map((r) => r['text'] as String).toList(),
      );
    }).toList();
  }

  /// Hizbs
  Future<List<HizbItem>> getHizbsWithFirstAyah() async {
    final rows = await customSelect(
      '''
        SELECT a.juz_no, a.hizb_fraction, a.surah, a.ayah, w.text
        FROM ayah_metas a
        JOIN words w ON w.surah = a.surah AND w.ayah = a.ayah
        INNER JOIN (
          SELECT juz_no, hizb_fraction, MIN(global_index) AS firstIndex
          FROM ayah_metas
          GROUP BY juz_no, hizb_fraction
        ) b ON a.global_index = b.firstIndex
        ORDER BY a.juz_no, a.hizb_fraction, w.word;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();

    final grouped = <String, List<Map<String, dynamic>>>{};

    for (final row in rows) {
      final key =
          "${row.read<int>('juz_no')}_${row.read<int>('hizb_fraction')}";
      grouped.putIfAbsent(key, () => []).add(row.data);
    }

    return grouped.entries.map((entry) {
      final first = entry.value.first;
      return HizbItem(
        juzNumber: first['juz_no'] as int,
        fraction: const HizbFractionConverter().fromSql(
          first['hizb_fraction'] as int,
        ),
        verseKey: VerseKey(first['surah'] as int, first['ayah'] as int),
        ayahWords: entry.value.map((r) => r['text'] as String).toList(),
      );
    }).toList();
  }
}
