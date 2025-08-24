import 'package:tajweed_ai/cache/page_cache.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/helpers/chapter_cache.dart';

abstract interface class QuranPageDatasource {
  Future<PageContentDto> getPageContent(int pageNo);
  Future<void> prefetchPagesAround(
    int centerPage, {
    int before = 2,
    int after = 2,
  });
  Stream<List<PageContentDto>> watchPartition(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
  });
  QuranDao get dao;
}

final class QuranPageDatasourceImpl implements QuranPageDatasource {
  final QuranDao _dao;

  final ChapterCache chapterCache;
  final PageCache pageCache;

  QuranPageDatasourceImpl({
    required QuranDao dao,
    required this.chapterCache,
    required this.pageCache,
  }) : _dao = dao;

  /// Expose DAO for helpers like prefetch
  @override
  QuranDao get dao => _dao;

  @override
  Future<PageContentDto> getPageContent(int pageNo) async {
    // 1) Try cache
    final cached = pageCache.get(pageNo);
    if (cached != null) return cached;

    // 2) Build fresh
    final metas = await dao.getPageAyatMetas(pageNo);
    final blocks = <PageBlockDto>[];

    if (metas.isNotEmpty) {
      // First-ayah contextual meta FOR THE PAGE
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

    final ayatKeys = metas.map((m) => (m.surah, m.ayah)).toList();
    final allWords = await dao.getWordsForAyat(ayatKeys);
    final wordsByAyah = <(int, int), List<WordRow>>{};
    for (final w in allWords) {
      wordsByAyah.putIfAbsent((w.surah, w.ayah), () => []).add(w);
    }
    // Render ayat with inline headers/basmalah on surah starts
    final chapterCacheMap = <int, ChapterHeaderDto>{};

    for (final a in metas) {
      // Insert header/basmalah when the FIRST ayah of a surah appears on this page
      if (a.ayah == 1) {
        var header = chapterCacheMap[a.surah];
        if (header == null) {
          final chap = await chapterCache.getChapterById(a.surah);
          if (chap != null) {
            header = ChapterHeaderDto(
              id: chap.id,
              nameArabic: chap.nameArabic,
              nameGlyph: chap.nameGlyph,
              bismillahPre: chap.bismillahPre,
            );
            chapterCacheMap[a.surah] = header;
          }
        }
        if (header != null) {
          blocks.add(SurahHeaderBlockDto(chapter: header));
          // Show basmalah if this surah uses pre-basmala
          if (header.bismillahPre) {
            blocks.add(BasmalahBlockDto(surahId: header.id));
          }
        }
      }
      final words = wordsByAyah[(a.surah, a.ayah)] ?? const [];
      blocks.add(AyahBlockDto(ayah: a, words: words));
    }

    final page = PageContentDto(pageNo: pageNo, blocks: blocks);

    // 3) Cache it
    await pageCache.set(page);

    return page;
  }

  // Prefetch helper (see §3)
  @override
  Future<void> prefetchPagesAround(
    int centerPage, {
    int before = 2,
    int after = 2,
  }) async {
    final futures = <Future>[];
    for (int p = centerPage - before; p <= centerPage + after; p++) {
      if (p <= 0) continue;
      // Ask the cache first
      final cached = pageCache.get(p);
      if (cached == null) {
        futures.add(
          getPageContent(p).then((page) {
            pageCache.set(page);
          }),
        );
      }
    }
    await Future.wait(futures);
  }

  @override
  Stream<List<PageContentDto>> watchPartition(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
  }) {
    return dao
        .watchPagesForPartition(mode, partitionNo, fraction: fraction)
        .asyncMap((pageNumbers) async {
          final pages = <PageContentDto>[];
          for (final p in pageNumbers) {
            pages.add(await getPageContent(p));
          }
          return pages;
        });
  }

  String _kPageKey(int pageNo) => 'page_layout_v1_$pageNo';
}

// ************ helper Dto classes
class PageContentDto {
  final int pageNo;
  final List<PageBlockDto> blocks;
  PageContentDto({required this.pageNo, required this.blocks});
}

class ChapterHeaderDto {
  final int id;
  final String nameArabic;
  final String nameGlyph;
  final bool bismillahPre;
  ChapterHeaderDto({
    required this.id,
    required this.nameArabic,
    required this.nameGlyph,
    required this.bismillahPre,
  });
}

abstract class PageBlockDto {}

class SurahHeaderBlockDto extends PageBlockDto {
  final ChapterHeaderDto chapter;
  SurahHeaderBlockDto({required this.chapter});
}

class BasmalahBlockDto extends PageBlockDto {
  final int surahId;
  BasmalahBlockDto({required this.surahId});
}

class PageMetaBlockDto extends PageBlockDto {
  final int? juz;
  final int? hizb;
  final int? ruku;
  final HizbFraction? hizbFraction;
  PageMetaBlockDto({this.juz, this.hizb, this.ruku, this.hizbFraction});
}

class AyahBlockDto extends PageBlockDto {
  final AyahMetaRow ayah;
  final List<WordRow> words;

  AyahBlockDto({required this.ayah, required this.words});
}

class PartitionMarkerBlockDto extends PageBlockDto {
  final PartitionMode mode;
  final int partitionId;
  PartitionMarkerBlockDto({required this.mode, required this.partitionId});
}
