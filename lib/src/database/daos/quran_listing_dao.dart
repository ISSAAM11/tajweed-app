import 'package:drift/drift.dart';
import 'package:html/parser.dart' as html;
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';
import 'package:tajweed_ai/src/database/tables/quran/chapters.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_model_helper.dart';

import '../app_database.dart';
import '../tables/quran/words.dart';

part 'quran_listing_dao.g.dart';

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
        SELECT a.page_no, a.surah, a.ayah,
              GROUP_CONCAT(w.text, ' ') as ayahText
        FROM ayah_metas a
        JOIN words w
          ON w.surah = a.surah AND w.ayah = a.ayah
        INNER JOIN (
            SELECT page_no, MIN(global_index) AS firstIndex
            FROM ayah_metas
            GROUP BY page_no
        ) b ON a.global_index = b.firstIndex
        GROUP BY a.page_no, a.surah, a.ayah
        ORDER BY a.page_no;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();

    final result = rows.map((row) {
      return PageItem(
        pageNumber: row.read<int>('page_no'),
        verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
        ayahText: stripRules(row.read<String>('ayahText')),
      );
    }).toList();

    return result;
  }

  /// Juz
  Future<List<JuzItem>> getJuzsWithFirstAyah() async {
    final rows = await customSelect(
      '''
        WITH numbered_words AS (
          SELECT w.text, w.surah, w.ayah,
                ROW_NUMBER() OVER (PARTITION BY w.surah, w.ayah ORDER BY w.word ASC) AS rn
            FROM words w
        )
        SELECT a.juz_no, a.surah, a.ayah,
              GROUP_CONCAT(nw.text, ' ') AS ayahText
          FROM ayah_metas a
          JOIN numbered_words nw
            ON nw.surah = a.surah AND nw.ayah = a.ayah AND nw.rn <= 4
        INNER JOIN (
              SELECT juz_no, MIN(global_index) AS firstIndex
                FROM ayah_metas
              GROUP BY juz_no
              ) b
            ON a.global_index = b.firstIndex
        GROUP BY a.juz_no, a.surah, a.ayah
        ORDER BY a.juz_no;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();

    final result = rows.map((row) {
      return JuzItem(
        juzNumber: row.read<int>('juz_no'),
        verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
        ayahText: stripRules(row.read<String>('ayahText')),
      );
    }).toList();

    return result;
  }

  /// Rukus
  Future<List<RukuItem>> getRukusWithFirstAyah() async {
    final rows = await customSelect(
      '''
      WITH numbered_words AS (
        SELECT w.text, w.surah, w.ayah,
              ROW_NUMBER() OVER (PARTITION BY w.surah, w.ayah ORDER BY w.word ASC) AS rn
          FROM words w
      )
      SELECT a.ruku_no, a.surah, a.ayah,
            GROUP_CONCAT(nw.text, ' ') AS ayahText
        FROM ayah_metas a
        JOIN numbered_words nw
          ON nw.surah = a.surah AND nw.ayah = a.ayah AND nw.rn <= 4
      INNER JOIN (
            SELECT ruku_no, MIN(global_index) AS firstIndex
              FROM ayah_metas
            GROUP BY ruku_no
            ) b
          ON a.global_index = b.firstIndex
      GROUP BY a.ruku_no, a.surah, a.ayah
      ORDER BY a.ruku_no;
  ''',
      readsFrom: {ayahMetas, words},
    ).get();
    final result = rows.map((row) {
      return RukuItem(
        rukuNumber: row.read<int>('ruku_no'),
        verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
        ayahText: stripRules(row.read<String>('ayahText')),
      );
    }).toList();
    return result;
  }

  /// Hizbs
  Future<List<HizbItem>> getHizbsWithFirstAyah() async {
    final rows = await customSelect(
      '''
      WITH numbered_words AS (
        SELECT w.text, w.surah, w.ayah,
              ROW_NUMBER() OVER (PARTITION BY w.surah, w.ayah ORDER BY w.word ASC) AS rn
          FROM words w
      )
      SELECT a.juz_no, a.hizb_fraction, a.surah, a.ayah,
            GROUP_CONCAT(nw.text, ' ') AS ayahText
        FROM ayah_metas a
        JOIN numbered_words nw
          ON nw.surah = a.surah AND nw.ayah = a.ayah AND nw.rn <= 4
      INNER JOIN (
            SELECT juz_no, hizb_fraction, MIN(global_index) AS firstIndex
              FROM ayah_metas
            GROUP BY juz_no, hizb_fraction
            ) b
          ON a.global_index = b.firstIndex
      GROUP BY a.juz_no, a.hizb_fraction, a.surah, a.ayah
      ORDER BY a.juz_no, a.hizb_fraction;
      ''',
      readsFrom: {ayahMetas, words},
    ).get();
    final result = rows.map((row) {
      return HizbItem(
        juzNumber: row.read<int>('juz_no'),
        fraction: const HizbFractionConverter().fromSql(
          row.read<int>('hizb_fraction'),
        ),
        verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
        ayahText: stripRules(row.read<String>('ayahText')),
      );
    }).toList();

    return result;
  }
}

String stripRules(String input) {
  final document = html.parseFragment(input);
  return document.text ?? ''; // removes all HTML tags
}
