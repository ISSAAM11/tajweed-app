import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/cache/page_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/quran_page_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/quran_page_remote_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/page/services/partition_snapshot_service.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';

class QuranPageDependencies implements Dependencies {
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
        pageCache: get<PageCache>(),
      ),
    );

    // Register remote API datasource
    di.registerLazySingleton<QuranPageRemoteDataSource>(
      () => QuranPageRemoteDataSourceImpl(
        client: get<Dio>(),
        cacheManager: get<CacheManager<SharedPreferences>>(),
        connectivityMonitor: get<ConnectivityMonitor>(),
      ),
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
