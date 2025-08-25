import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart'
    show ListingDataDto, QuranListingDatasource;
import 'package:tajweed_ai/src/features/home/quran/datasource/meta/quran_meta_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/quran_page_datasource.dart';

abstract interface class QuranDatasource {
  // Listing
  Future<ListingDataDto> getListingData();
  // Meta
  Stream<AyahMetaRow?> watchPageMeta(int pageNo);
  Future<int?> getPartitionForAyah(PartitionMode mode, int globalIndex);
  // Content
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
}

final class QuranDatasourceImpl implements QuranDatasource {
  final QuranListingDatasource listingDatasource;
  final QuranPageDatasource pageDatasource;
  final QuranMetaDatasource metaDatasource;

  QuranDatasourceImpl({
    required this.pageDatasource,
    required this.listingDatasource,
    required this.metaDatasource,
  });

  /// Fetch all listing data (pages, juzs, rukus, hizbs) in parallel
  @override
  Future<ListingDataDto> getListingData() async {
    return listingDatasource.getListingData();
  }

  @override
  Future<void> prefetchPagesAround(
    int centerPage, {
    int before = 2,
    int after = 2,
  }) {
    return pageDatasource.prefetchPagesAround(
      centerPage,
      before: before,
      after: after,
    );
  }

  @override
  Future<PageContentDto> getPageContent(int pageNo) {
    return pageDatasource.getPageContent(pageNo);
  }

  @override
  Stream<List<PageContentDto>> watchPartition(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
  }) {
    return pageDatasource.watchPartition(mode, partitionNo, fraction: fraction);
  }

  @override
  Future<int?> getPartitionForAyah(PartitionMode mode, int globalIndex) {
    return metaDatasource.getPartitionForAyah(mode, globalIndex);
  }

  @override
  Stream<AyahMetaRow?> watchPageMeta(int pageNo) {
    return metaDatasource.watchPageMeta(pageNo);
  }
}
