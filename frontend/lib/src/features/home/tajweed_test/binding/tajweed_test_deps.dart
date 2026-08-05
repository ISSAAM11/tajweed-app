import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/features/home/tajweed_test/datasource/tajweed_eval_datasource.dart';
import 'package:tajweed_ai/src/features/home/tajweed_test/vm/tajweed_test_bloc.dart';

class TajweedTestDependencies implements Dependencies {
  @override
  void inject() {
    di.registerLazySingleton<TajweedEvalDataSource>(
      () => HuggingFaceEvalDataSource(),
    );
    di.registerFactory<TajweedTestBloc>(
      () => TajweedTestBloc(get<TajweedEvalDataSource>()),
    );
  }
}
