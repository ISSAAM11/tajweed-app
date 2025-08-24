import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';
import 'package:tajweed_ai/src/database/daos/quran_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/helpers/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/helpers/quran_meta_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/helpers/quran_page_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';

class QuranDependencies implements Dependencies {
  @override
  void inject() {
    // $ DAO (Drift layer)
    di.registerLazySingleton<QuranDao>(() => QuranDao(get<AppDatabase>()));

    // $ Repository / DataSource (same thing in your setup)
    di.registerLazySingleton<QuranDatasource>(
      () => QuranDatasourceImpl(
        pageDatasource: get<QuranPageDatasource>(),
        listingDatasource: get<QuranListingDatasource>(),
        metaDatasource: get<QuranMetaDatasource>(), // online/offline detection
      ),
    );
    // $ Bloc (UI state manager, depends on datasource)
    di.registerFactory<QuranListingBloc>(
      () => QuranListingBloc(get<QuranDatasource>(), PartitionMode.surah),
    );
  }
}
