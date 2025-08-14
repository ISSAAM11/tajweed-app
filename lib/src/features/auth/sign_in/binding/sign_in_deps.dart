import '../../../../app/binding/app_bindings.dart';
import '../../../../base/dependencies/dependencies.dart';
import '../data/datasource/sign_in_datasource.dart';
import '../bloc/sign_in_bloc.dart';

class SignInDependencies implements Dependencies {
  @override
  void inject() {
    //$ Data sources
    di.registerLazySingleton<SignInDataSource>(
      () => SignInDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );

    //? Bloc
    di.registerFactory(() => SignInBloc(get()));
  }
}
