import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_listing_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart'
    show HizbFraction, VerseKey;
import 'package:tajweed_ai/src/features/home/quran/datasource/cache/listing_cache.dart';

abstract interface class QuranListingDatasource {
  Future<ListingDataDto> getListingData();
  Future<ChapterRow?> getChapterById(int id);
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
      chapters: results[0] as List<ChapterRow>,
      pages:
          results[1]
              as List<({int pageNumber, VerseKey verseKey, String ayahText})>,
      juzs:
          results[2]
              as List<({int juzNumber, VerseKey verseKey, String ayahText})>,
      rukus:
          results[3]
              as List<({int rukuNumber, VerseKey verseKey, String ayahText})>,
      hizbs:
          results[4]
              as List<
                ({
                  int juzNumber,
                  HizbFraction fraction,
                  VerseKey verseKey,
                  String ayahText,
                })
              >,
    );
    // 3) Save cache
    await listingCache.set(dto);
    return dto;
  }

  @override
  Future<ChapterRow?> getChapterById(int id) async {
    final listing = await getListingData();
    return listing.chapters.firstWhere((c) => c.id == id);
  }
}

class ListingDataDto {
  final List<ChapterRow> chapters;
  final List<({int pageNumber, VerseKey verseKey, String ayahText})>? pages;
  final List<({int juzNumber, VerseKey verseKey, String ayahText})>? juzs;
  final List<({int rukuNumber, VerseKey verseKey, String ayahText})>? rukus;
  final List<
    ({int juzNumber, HizbFraction fraction, VerseKey verseKey, String ayahText})
  >?
  hizbs;

  const ListingDataDto({
    required this.chapters,
    this.pages,
    this.juzs,
    this.rukus,
    this.hizbs,
  });
}
