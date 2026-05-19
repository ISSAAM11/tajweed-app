import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/page/binding/quran_page_deps.dart';

import '../services/tajweed_send_service.dart';
import '../vm/tajweed_send_bloc.dart';

/// Dependencies for the tajweed_test feature.
///
/// It reuses the QuranPage dependencies and adds a very small
/// TajweedSendService + TajweedSendBloc.
final class TajweedTestDependencies implements Dependencies {
  @override
  void inject() {
    // Reuse all QuranPage feature dependencies.
    QuranPageDependencies().inject();

    // Register Tajweed test HTTP service (uses Dio under the hood).
    di.registerLazySingleton<TajweedSendService>(
      () => TajweedSendService(get<Dio>()),
    );

    // Each tajweed test screen gets a fresh send bloc.
    di.registerFactory<TajweedSendBloc>(
      () => TajweedSendBloc(get<TajweedSendService>()),
    );
  }
}
