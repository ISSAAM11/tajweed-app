import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';
import 'package:tajweed_ai/src/features/quran/datasource/quran_datasource.dart';
import 'package:tajweed_ai/src/features/quran/vm/quran_bloc.dart';

class QuranDependencies implements Dependencies {
  @override
  void inject() {
    // $ DAO (Drift layer)
    di.registerLazySingleton<QuranDao>(() => QuranDao(get<AppDatabase>()));

    // $ Repository / DataSource (same thing in your setup)
    di.registerLazySingleton<QuranDatasource>(
      () => QuranDatasourceImpl(
        dao: get<QuranDao>(),
        client: get(), // future API client
        cacheManager: get(), // local cache if needed
        connectivityMonitor: get(), // online/offline detection
      ),
    );

    // $ Bloc (UI state manager, depends on datasource)
    di.registerFactory<QuranBloc>(() => QuranBloc(get<QuranDatasource>()));
  }
}
