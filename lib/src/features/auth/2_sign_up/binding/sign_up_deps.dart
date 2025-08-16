import '../../../../base/dependencies/dependencies.dart';
import '../datasource/sign_up_datasource.dart';
import '../vm/bloc/sign_up_bloc.dart';

class SignUpDependencies implements Dependencies {
  @override
  void inject() {
    //$ Data sources
    di.registerLazySingleton<SignUpDataSource>(
      () => SignUpDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );

    //? Bloc
    di.registerInstance(SignUpBloc(get()));
  }
}
