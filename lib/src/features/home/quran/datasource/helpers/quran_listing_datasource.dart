import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_listing_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart'
    show HizbFraction, VerseKey;

abstract interface class QuranListingDatasource {
  Future<ListingDataDto> getListingData();
}

final class QuranListingDatasourceImpl implements QuranListingDatasource {
  final QuranListingDao listingDao;

  QuranListingDatasourceImpl({required this.listingDao});

  /// Fetch all listing data (pages, juzs, rukus, hizbs) in parallel
  @override
  Future<ListingDataDto> getListingData() async {
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

    return ListingDataDto(
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
