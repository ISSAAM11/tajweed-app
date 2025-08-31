import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/cache/page_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/partition_snapshot_service.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/quran_page_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_bloc.dart';

class QuranDependencies implements Dependencies {
  @override
  void inject() {
    // Feature caches
    di.registerLazySingleton<PageCache>(
      () => PageCache(
        cacheManager: get<CacheManager<SharedPreferences>>(),
        capacity: 10,
      ),
    );

    di.registerLazySingleton<QuranPageDatasource>(
      () => QuranPageDatasourceImpl(
        pageDao: get<QuranPageDao>(),
        listingDatasource: get<QuranListingDatasource>(),
        pageCache: get<PageCache>(),
      ),
    );

    di.registerLazySingleton<QuranDatasource>(
      () => QuranDatasourceImpl(
        pageDatasource: get<QuranPageDatasource>(),
        listingDatasource: get<QuranListingDatasource>(),
      ),
    );

    // Feature bloc
    di.registerLazySingleton<QuranListingBloc>(
      () => QuranListingBloc(get<QuranDatasource>(), PartitionMode.surah),
    );

    // each screen gets a fresh Bloc
    di.registerFactory<QuranPageBloc>(
      () => QuranPageBloc(
        get<QuranPageDatasource>(),
        get<PartitionSnapshotService>(),
      ),
    );
  }
}
