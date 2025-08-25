import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/cache/page_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/meta/quran_meta_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/quran_page_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';

class QuranDependencies implements Dependencies {
  @override
  void inject() {
    di.registerLazySingleton<QuranDao>(() => QuranDao(get<AppDatabase>()));
    // Feature caches
    di.registerLazySingleton<PageCache>(
      () => PageCache(cacheManager: get<CacheManager>(), capacity: 5),
    );
    // Feature datasources
    di.registerLazySingleton<QuranMetaDatasource>(
      () => QuranMetaDatasourceImpl(dao: get<QuranDao>()),
    );

    di.registerLazySingleton<QuranPageDatasource>(
      () => QuranPageDatasourceImpl(
        dao: get<QuranDao>(),
        listingDatasource: get<QuranListingDatasource>(),
        pageCache: get<PageCache>(),
      ),
    );

    di.registerLazySingleton<QuranDatasource>(
      () => QuranDatasourceImpl(
        pageDatasource: get<QuranPageDatasource>(),
        listingDatasource: get<QuranListingDatasource>(),
        metaDatasource: get<QuranMetaDatasource>(),
      ),
    );

    // Feature bloc
    di.registerLazySingleton<QuranListingBloc>(
      () => QuranListingBloc(get<QuranDatasource>(), PartitionMode.surah),
    );
  }
}
