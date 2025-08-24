import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';

class ChapterCache {
  final QuranDao dao;
  final Map<int, ChapterRow> _cache = {};

  ChapterCache(this.dao);

  /// Get a chapter by ID (cached)
  Future<ChapterRow?> getChapterById(int id) async {
    if (_cache.containsKey(id)) return _cache[id];
    final chap = await dao.getChapterById(id);
    if (chap != null) _cache[id] = chap;
    return chap;
  }

  /// Get all chapters (cached)
  Future<List<ChapterRow>> getAllChapters() async {
    if (_cache.isNotEmpty) return _cache.values.toList();
    final chapters = await dao.getAllChapters();
    for (final c in chapters) _cache[c.id] = c;
    return chapters;
  }
}
