import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/ayah_metas.dart';
import 'package:tajweed_ai/src/database/tables/quran/chapters.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

import '../app_database.dart';
import '../tables/quran/words.dart';

part 'quran_listing_dao.g.dart';

@DriftAccessor(tables: [AyahMetas, Words, Chapters])
class QuranListingDao extends DatabaseAccessor<AppDatabase>
    with _$QuranListingDaoMixin {
  QuranListingDao(super.db);

  /// Chapters (just return them directly if you have Chapters table already)
  // Future<List<ChapterRow>> getChapters() => select(chapters).get();

  Future<List<ChapterRow>> getChapters() async {
    try {
      final chaptersResult = await select(chapters).get();
      return chaptersResult;
    } catch (e, stackTrace) {
      Debugger.red('Error fetching chapters: $e');
      Debugger.red(stackTrace);
      rethrow;
    }
  }

  /// Pages
  Future<List<({int pageNumber, VerseKey verseKey, String ayahText})>>
  getPagesWithFirstAyah() async {
    try {
      final rows = await customSelect(
        '''
      SELECT a.page_no, a.surah, a.ayah,
             (SELECT w.text FROM words w
              WHERE w.surah = a.surah AND w.ayah = a.ayah
              ORDER BY w.word ASC LIMIT 1) as firstWord
      FROM ayah_metas a
      INNER JOIN (
          SELECT page_no, MIN(global_index) AS firstIndex
          FROM ayah_metas
          GROUP BY page_no
      ) b ON a.global_index = b.firstIndex
      ORDER BY a.page_no
      ''',
        readsFrom: {ayahMetas, words},
      ).get();

      final result = rows.map((row) {
        return (
          pageNumber: row.read<int>('page_no'),
          verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
          ayahText: row.read<String>('firstWord'),
        );
      }).toList();
      Debugger.green('got pages succesfully');
      return result;
    } catch (e) {
      Debugger.red('Error fetching pages with first ayah: $e');
      rethrow;
    }
  }

  /// Juz
  Future<List<({int juzNumber, VerseKey verseKey, String ayahText})>>
  getJuzsWithFirstAyah() async {
    try {
      final rows = await customSelect(
        '''
  SELECT a.juz_no, a.surah, a.ayah,
         (SELECT w.text FROM words w
          WHERE w.surah = a.surah AND w.ayah = a.ayah
          ORDER BY w.word ASC LIMIT 1) as firstWord
  FROM ayah_metas a
  INNER JOIN (
      SELECT juz_no, MIN(global_index) AS firstIndex
      FROM ayah_metas
      GROUP BY juz_no
  ) b ON a.global_index = b.firstIndex
  ORDER BY a.juz_no
  ''',
        readsFrom: {ayahMetas, words},
      ).get();

      final result = rows.map((row) {
        return (
          juzNumber: row.read<int>('juz_no'),
          verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
          ayahText: row.read<String>('firstWord'),
        );
      }).toList();
      Debugger.green('got juzs successfully');
      return result;
    } on Exception catch (e) {
      Debugger.red('Error fetching juzs with first ayah: $e');
      rethrow;
      // TODO
    }
  }

  /// Rukus
  Future<List<({int rukuNumber, VerseKey verseKey, String ayahText})>>
  getRukusWithFirstAyah() async {
    try {
      final rows = await customSelect(
        '''
  SELECT a.ruku_no, a.surah, a.ayah,
         (SELECT w.text FROM words w
          WHERE w.surah = a.surah AND w.ayah = a.ayah
          ORDER BY w.word ASC LIMIT 1) as firstWord
  FROM ayah_metas a
  INNER JOIN (
      SELECT ruku_no, MIN(global_index) AS firstIndex
      FROM ayah_metas
      GROUP BY ruku_no
  ) b ON a.global_index = b.firstIndex
  ORDER BY a.ruku_no
  ''',
        readsFrom: {ayahMetas, words},
      ).get();
      final result = rows.map((row) {
        return (
          rukuNumber: row.read<int>('ruku_no'),
          verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
          ayahText: row.read<String>('firstWord'),
        );
      }).toList();
      Debugger.green('got rukus successfully _rukus');
      return result;
    } on Exception catch (e) {
      Debugger.red('Error fetching rukus with first ayah: $e');
      rethrow;
    }
  }

  /// Hizbs
  Future<
    List<
      ({
        int juzNumber,
        HizbFraction fraction,
        VerseKey verseKey,
        String ayahText,
      })
    >
  >
  getHizbsWithFirstAyah() async {
    try {
      final rows = await customSelect(
        '''
  SELECT a.juz_no, a.hizb_fraction, a.surah, a.ayah,
         (SELECT w.text FROM words w
          WHERE w.surah = a.surah AND w.ayah = a.ayah
          ORDER BY w.word ASC LIMIT 1) as firstWord
  FROM ayah_metas a
  INNER JOIN (
      SELECT juz_no, hizb_fraction, MIN(global_index) AS firstIndex
      FROM ayah_metas
      GROUP BY juz_no, hizb_fraction
  ) b ON a.global_index = b.firstIndex
  ORDER BY a.juz_no, a.hizb_fraction
  ''',
        readsFrom: {ayahMetas, words},
      ).get();
      final result = rows.map((row) {
        return (
          juzNumber: row.read<int>('juz_no'),
          fraction: const HizbFractionConverter().fromSql(
            row.read<int>('hizb_fraction'),
          ),
          verseKey: VerseKey(row.read<int>('surah'), row.read<int>('ayah')),
          ayahText: row.read<String>('firstWord'),
        );
      }).toList();
      Debugger.green('got Hizbs successfully _rukus');

      return result;
    } on Exception catch (e) {
      Debugger.red('Error fetching hizbs with first ayah: $e');
      rethrow;
      // TODO
    }
  }
}
