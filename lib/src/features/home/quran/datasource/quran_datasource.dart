import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart'
    show ListingDataDto, QuranListingDatasource;
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

  QuranDatasourceImpl({
    required this.pageDatasource,
    required this.listingDatasource,
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
}
