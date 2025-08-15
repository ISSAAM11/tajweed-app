import '../../../base/dependencies/dependencies.dart';
import '../datasource/shift_handover_datasource_impl.dart';
import '../vm/bloc/shift_handover_bloc.dart';

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
    di.registerInstance(ShiftHandoverBloc(get()));
  }
}
