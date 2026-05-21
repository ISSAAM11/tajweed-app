import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:generic_requester/generic_requester.dart' show Dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/src/app/locale/locale_bloc.dart';
import 'package:tajweed_ai/src/app/theme/theme_bloc.dart';
import 'package:tajweed_ai/src/core/services/locale_preference_service.dart';
import 'package:tajweed_ai/src/core/services/theme_preference_service.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_listing_dao.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/page/services/partition_snapshot_service.dart';

import '../../core/dependency/get_it_container.dart';
import '../../core/managers/cache/cache_manager_impl.dart';
import '../../core/managers/connectivity/connectivity_plus.dart';

//= Use this to inject dependencies
final DependecyInjectionContainer di = GetItContainer();

//= Use this to get dependencies
T get<T extends Object>([_]) => di.get<T>();

final class AppBinding extends AppBindings {
  @override
  Future<void> asynchronous() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    // 📦 External packages
    di.registerSingleton<SharedPreferences>(prefs);

    // 📦 Database
    di.registerLazySingleton<AppDatabase>(() => AppDatabase());

    // 📦 DAOs
    di.registerLazySingleton<QuranListingDao>(
      () => QuranListingDao(get<AppDatabase>()),
    );
    di.registerLazySingleton<QuranPageDao>(
      () => QuranPageDao(get<AppDatabase>()),
    );
    di.registerSingletonAsync<PartitionSnapshotService>(() async {
      final dao = get<QuranPageDao>();
      final svc = PartitionSnapshotService(dao);
      await svc.load();
      return svc;
    });

    // 📦 Cache
    di.registerLazySingleton<CacheManager<SharedPreferences>>(
      () => CacheManagerImpl(prefs),
    );
    di.registerLazySingleton<ListingCache>(
      () => ListingCache(get<CacheManager<SharedPreferences>>()),
    );
    di.registerLazySingleton<LastSelectedSurahService>(
      () => LastSelectedSurahService(get<CacheManager<SharedPreferences>>()),
    );

    // 📦 Locale
    di.registerLazySingleton<LocalePreferenceService>(
      () => LocalePreferenceService(get<CacheManager<SharedPreferences>>()),
    );
    di.registerSingleton<LocaleBloc>(
      LocaleBloc(get<LocalePreferenceService>()),
    );

    // 📦 Theme
    di.registerLazySingleton<ThemePreferenceService>(
      () => ThemePreferenceService(get<CacheManager<SharedPreferences>>()),
    );
    di.registerSingleton<ThemeBloc>(
      ThemeBloc(get<ThemePreferenceService>()),
    );

    // 📦 Datasource (prewarmed)
    di.registerSingletonAsync<QuranListingDatasource>(() async {
      final ds = QuranListingDatasourceImpl(
        listingDao: get<QuranListingDao>(),
        listingCache: get<ListingCache>(),
      );
      await ds.getListingData(); // preload data into cache
      return ds;
    });
  }

  @override
  void synchronous() {
    //? Managers
    di.registerLazySingleton(() => FlutterSecureStorage());
    //& Packages
    di.registerLazySingleton(() => Dio());
    di.registerLazySingleton<ConnectivityMonitor>(
      () => ConnectivityPlus(Connectivity()),
    );
  }
}
