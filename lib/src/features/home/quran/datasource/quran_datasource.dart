import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart'
    show ListingDataDto, QuranListingDatasource;
import 'package:tajweed_ai/src/features/home/quran/datasource/meta/quran_meta_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/quran_page_datasource.dart';

/// Facade for all Quran-related data operations.
///
/// This interface hides the complexity of dealing with
/// multiple data sources (listing, page, meta) and provides
/// a single entry point for the rest of the app.
abstract interface class QuranDatasource {
  // -------------------
  // Listing operations
  // -------------------

  /// Fetches all Quran listing data (chapters, pages, juzs, rukus, hizbs).
  Future<ListingDataDto> getListingData();

  // -------------------
  // Meta operations
  // -------------------

  /// Watches metadata for a specific page (async stream of updates).
  Stream<AyahMetaRow?> watchPageMeta(int pageNo);

  /// Returns the partition number (e.g., juz, hizb, etc.)
  /// for a given ayah by its global index.
  Future<int?> getPartitionForAyah(PartitionMode mode, VerseKey key);

  // -------------------
  // Content operations
  // -------------------

  /// Returns the content (ayat, surah headers, etc.) of a specific page.
  Future<PageContentDto> getPageContent(int pageNo);
}

/// Implementation of [QuranDatasource].
///
/// Acts as a facade that delegates to the specialized datasources:
/// - [QuranListingDatasource] for listings (chapters, juzs, pages, etc.)
/// - [QuranPageDatasource] for page content & prefetching
/// - [QuranMetaDatasource] for metadata (ayah <-> partition relations, etc.)
final class QuranDatasourceImpl implements QuranDatasource {
  final QuranListingDatasource listingDatasource;
  final QuranPageDatasource pageDatasource;
  final QuranMetaDatasource metaDatasource;

  QuranDatasourceImpl({
    required this.pageDatasource,
    required this.listingDatasource,
    required this.metaDatasource,
  });

  // -------------------
  // Listing delegation
  // -------------------

  @override
  Future<ListingDataDto> getListingData() {
    return listingDatasource.getListingData();
  }

  // -------------------
  // Content delegation
  // -------------------
  @override
  Future<PageContentDto> getPageContent(int pageNo) {
    return pageDatasource.getPageContent(pageNo);
  }

  // -------------------
  // Meta delegation
  // -------------------

  @override
  Future<int?> getPartitionForAyah(PartitionMode mode, VerseKey key) {
    return metaDatasource.getPartitionForAyah(mode, key);
  }

  @override
  Stream<AyahMetaRow?> watchPageMeta(int pageNo) {
    return metaDatasource.watchPageMeta(pageNo);
  }
}
