import '../../../app/binding/app_bindings.dart';
import '../../../base/dependencies/dependencies.dart';
import '../bloc/shift_handover_bloc.dart';
import '../data/datasource/shift_handover_datasource_impl.dart';

class ShiftHandoverDependencies implements Dependencies {
  @override
  void inject() {
    //$ Data sources
    di.registerLazySingleton<ShiftHandoverDataSource>(
      () => ShiftHandoverDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );

    //? Bloc
    di.registerFactory(() => ShiftHandoverBloc(get()));
  }
}
