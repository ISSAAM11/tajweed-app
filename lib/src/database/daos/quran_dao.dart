import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/quran/chapters.dart';
import '../tables/quran/hizb.dart';
import '../tables/quran/juz.dart';
import '../tables/quran/ruku.dart';
import '../tables/quran/word.dart';

part 'quran_dao.g.dart';

@DriftAccessor(tables: [Words, Hizbs, Juzs, Rukus, Chapters])
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(super.db);

  /// Get all chapters
  Future<List<Chapter>> getChapters() {
    return select(chapters).get();
  }

  /// Get all words in a given surah
  Future<List<Word>> getWordsBySurah(int surahId) {
    return (select(words)..where((w) => w.surah.equals(surahId))).get();
  }

  /// Get all words in a specific ayah of a surah
  Future<List<Word>> getWordsInAyah(int surahId, int ayahNumber) {
    return (select(
      words,
    )..where((w) => w.surah.equals(surahId) & w.ayah.equals(ayahNumber))).get();
  }
}
