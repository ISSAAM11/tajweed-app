import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/cache/page_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

abstract interface class QuranPageDatasource {
  Future<PageContentDto> getPageContent(int pageNo);
  Future<int> getPageForVerse(VerseKey verseKey);
  Future<ChapterHeaderDto> getChapterHeader(int surahIndex);
  Future<List<PageLinesDto>> getPageLines(int surahIndex);
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

  @override
  Future<List<PageLinesDto>> getPageLines(int surahIndex) async {
    return pageDao.getPageLines(surahIndex);
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
    final pageLines = await pageDao.getPageLines(pageNo);
    final blocks = <PageBlockDto>[];

    // Get page meta for the first line (juz, hizb, ruku info)
    final metas = await pageDao.getPageAyatMetas(pageNo);
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

    // Get all words for the page at once
    final ayatKeys = metas.map((m) => VerseKey(m.surah, m.ayah)).toList();
    final allWords = await pageDao.getWordsForAyat(ayatKeys);
    allWords.sort((a, b) {
      if (a.surah != b.surah) return a.surah.compareTo(b.surah);
      if (a.ayah != b.ayah) return a.ayah.compareTo(b.ayah);
      return a.word.compareTo(b.word);
    });

    final chapterCacheMap = <int, ChapterHeaderDto>{};
    // List<List<WordRow>> currentAyatList = [];
    int currentWordIndex = 0; // Track position in allWords list

    for (final line in pageLines) {
      switch (line.lineType) {
        case 'surah_name':
          // Flush any accumulated ayat before adding surah header
          // if (currentAyatList.isNotEmpty) {
          //   blocks.add(PageAyatsBlockDto(pageAyahs: List.of(currentAyatList)));
          //   currentAyatList.clear();
          // }
          var header = chapterCacheMap[line.surahNumber!];
          if (header == null) {
            final chap = await pageDao.getSurahName(line.surahNumber!);
            header = ChapterHeaderDto(
              id: chap.id,
              nameArabic: chap.nameArabic,
              nameGlyph: chap.nameGlyph,
              bismillahPre: chap.bismillahPre,
              revelationPlace: chap.revelationPlace,
            );
            chapterCacheMap[line.surahNumber!] = header;
          }
          blocks.add(SurahHeaderBlockDto(chapter: header));

          break;

        case 'basmallah':
          blocks.add(BasmalahBlockDto(surahId: line.lineNumber));
          break;

        case 'ayah':
          final wordsInLine = line.lastWordId! - line.firstWordId! + 1;

          final lineWords = allWords
              .skip(currentWordIndex)
              .take(wordsInLine)
              .toList();
          currentWordIndex += wordsInLine;

          if (lineWords.isNotEmpty) {
            blocks.add(
              LineWordsBlockDto(
                lineWords: lineWords,
                isCentered: line.isCentered,
              ),
            );
          }
          break;
        default:
          break;
      }
    }

    // // Add any remaining ayat
    // if (currentAyatList.isNotEmpty) {
    //   blocks.add(PageAyatsBlockDto(pageAyahs: List.of(currentAyatList)));
    // }

    return PageContentDto(pageNo: pageNo, blocks: blocks);
  }
}
