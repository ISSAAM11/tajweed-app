import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/cache/page_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

abstract interface class QuranPageDatasource {
  Future<PageContentDto> getPageContent(int pageNo);
  Future<int> getPageForVerse(VerseKey verseKey);
  Future<ChapterHeaderDto> getChapterHeader(int surahIndex);
}

final class QuranPageDatasourceImpl implements QuranPageDatasource {
  final PageCache pageCache;
  final QuranPageDao pageDao;
  QuranPageDatasourceImpl({required this.pageDao, required this.pageCache});

  @override
  Future<int> getPageForVerse(VerseKey verseKey) async {
    return pageDao.getPageForVerse(verseKey);
  }

  @override
  Future<ChapterHeaderDto> getChapterHeader(int surahIndex) async {
    return pageDao.getChapterHeader(surahIndex);
  }

  /// Public entry point: builds or returns cached full page, then optionally filters for a surah.
  @override
  Future<PageContentDto> getPageContent(int pageNo) async {
    // 1) Fast path: cached
    final cached = pageCache.get(pageNo);
    if (cached != null) return cached;

    // 2) Build fresh
    final built = await _buildPageContent(pageNo);

    // 3) Cache it
    await pageCache.set(built);

    // 4) Apply filter if needed
    return built;
  }

  /// Builds the full PageContentDto.
  Future<PageContentDto> _buildPageContent(int pageNo) async {
    final metas = await pageDao.getPageAyatMetas(pageNo);
    final blocks = <PageBlockDto>[];

    if (metas.isNotEmpty) {
      final first = metas.first;
      blocks.add(
        PageMetaBlockDto(
          juz: first.juzNo,
          hizb: first.hizbNo,
          ruku: first.rukuNo,
          hizbFraction: first.hizbFraction,
        ),
      );
    }
    // Collect words
    final ayatKeys = metas.map((m) => (VerseKey(m.surah, m.ayah))).toList();
    final allWords = await pageDao.getWordsForAyat(ayatKeys);
    final wordsByAyah = <VerseKey, List<WordRow>>{};
    for (final w in allWords) {
      wordsByAyah.putIfAbsent(VerseKey(w.surah, w.ayah), () => []).add(w);
    }
    // Render ayat with inline headers/basmalah on surah starts
    final chapterCacheMap = <int, ChapterHeaderDto>{};
    final List<List<WordRow>> ayatList = [];
    for (final a in metas) {
      // Surah start
      if (a.ayah == 1) {
        if (ayatList.isNotEmpty) {
          blocks.add(PageAyatsBlockDto(pageAyahs: List.of(ayatList)));
          ayatList.clear();
        }
        var header = chapterCacheMap[a.surah];
        if (header == null) {
          final chap = await pageDao.getSurahName(a.surah);

          header = ChapterHeaderDto(
            id: chap.id,
            nameArabic: chap.nameArabic,
            nameGlyph: chap.nameGlyph,
            bismillahPre: chap.bismillahPre,
            revelationPlace: chap.revelationPlace,
          );
          chapterCacheMap[a.surah] = header;
        }
        blocks.add(SurahHeaderBlockDto(chapter: header));
        if (header.bismillahPre) {
          blocks.add(BasmalahBlockDto(surahId: header.id));
        }
      }
      final words = wordsByAyah[VerseKey(a.surah, a.ayah)] ?? const [];
      blocks.add(AyahBlockDto(ayah: a, words: words));
      ayatList.add(words);
    }
    blocks.add(PageAyatsBlockDto(pageAyahs: List.of(ayatList)));

    return PageContentDto(pageNo: pageNo, blocks: blocks);
  }
}
