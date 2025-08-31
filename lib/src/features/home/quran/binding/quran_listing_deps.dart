import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_bloc.dart';

class QuranListingDependencies implements Dependencies {
  @override
  void inject() {
    // Feature bloc
    di.registerLazySingleton<QuranListingBloc>(
      () =>
          QuranListingBloc(get<QuranListingDatasource>(), PartitionMode.surah),
    );
  }
}
