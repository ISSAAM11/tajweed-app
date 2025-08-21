import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/sajdahs.dart';

import '../app_database.dart';
import '../tables/quran/chapters.dart';
import '../tables/quran/hizbs.dart';
import '../tables/quran/juzs.dart';
import '../tables/quran/rukus.dart';
import '../tables/quran/words.dart';

part 'quran_dao.g.dart';

@DriftAccessor(tables: [Words, Hizbs, Juzs, Sajdahs, Rukus, Chapters])
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(super.db);

  /// Get all chapters
  Future<List<ChapterRow>> getAllChapters() => select(chapters).get();

  /// Get all juzs
  Future<List<JuzRow>> getAllJuzs() => select(juzs).get();

  /// Get all hizbs
  Future<List<HizbRow>> getAllHizbs() => select(hizbs).get();

  /// Get all rukus
  Future<List<RukuRow>> getAllRukus() => select(rukus).get();

  /// Get all sajdahs
  Future<List<SajdahRow>> getAllSajdahs() => select(sajdahs).get();

  /// Get words for a specific ayah
  Future<List<WordRow>> getWordsForAyah(int chapterId, int ayahNo) {
    return (select(
      words,
    )..where((w) => w.surah.equals(chapterId) & w.ayah.equals(ayahNo))).get();
  }
}
