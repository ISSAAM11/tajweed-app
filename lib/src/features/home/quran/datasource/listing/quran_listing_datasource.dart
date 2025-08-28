import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_listing_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_model_helper.dart';

abstract interface class QuranListingDatasource {
  Future<ListingDataDto> getListingData();
  Future<ChapterItem?> getChapterById(int id);
}

final class QuranListingDatasourceImpl implements QuranListingDatasource {
  final QuranListingDao listingDao;
  final ListingCache listingCache;

  QuranListingDatasourceImpl({
    required this.listingDao,
    required this.listingCache,
  });

  /// Fetch all listing data (pages, juzs, rukus, hizbs) in parallel
  @override
  Future<ListingDataDto> getListingData() async {
    // 1) Try cache
    final cached = listingCache.get();
    if (cached != null) return cached;

    // 2) Fetch fresh
    final results = await Future.wait([
      listingDao.getChapters(), // List<ChapterRow>
      listingDao
          .getPagesWithFirstAyah(), // List<({int pageNumber, VerseKey verseKey, String ayahText})>
      listingDao
          .getJuzsWithFirstAyah(), // List<({int juzNumber, VerseKey verseKey, String ayahText})>
      listingDao
          .getRukusWithFirstAyah(), // List<({int rukuNumber, VerseKey verseKey, String ayahText})>
      listingDao
          .getHizbsWithFirstAyah(), // List<({int juzNumber, HizbFraction fraction, VerseKey verseKey, String ayahText})>
    ]);
    final dto = ListingDataDto(
      chapters: (results[0] as List<ChapterRow>)
          .map(ChapterItem.fromChapterRow)
          .toList(),
      pages: results[1] as List<PageItem>,
      juzs: results[2] as List<JuzItem>,
      rukus: results[3] as List<RukuItem>,
      hizbs: results[4] as List<HizbItem>,
    );
    // 3) Save cache
    await listingCache.set(dto);
    return dto;
  }

  @override
  Future<ChapterItem?> getChapterById(int id) async {
    final listing = await getListingData();
    return listing.chapters.firstWhere((c) => c.id == id);
  }
}

class ListingDataDto {
  final List<ChapterItem> chapters;
  final List<PageItem> pages;
  final List<JuzItem> juzs;
  final List<RukuItem> rukus;
  final List<HizbItem> hizbs;

  const ListingDataDto({
    required this.chapters,
    required this.pages,
    required this.juzs,
    required this.rukus,
    required this.hizbs,
  });
}
