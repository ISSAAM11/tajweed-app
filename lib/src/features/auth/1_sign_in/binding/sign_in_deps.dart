import '../../../../base/dependencies/dependencies.dart';
import '../datasource/sign_in_datasource.dart';
import '../vm/bloc/sign_in_bloc.dart';

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

    di.registerInstance<SignInBloc>(SignInBloc(get()));
  }
}
