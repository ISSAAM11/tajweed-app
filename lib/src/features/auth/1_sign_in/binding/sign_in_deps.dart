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

    //? BlocFactory<SignInBloc>(() => SignInBloc(get()));
    //? this means that the bloc will be created every time the widget is built
    //? and the memory will be freed when the widget is disposed
    //? and the bloc will be created again when the widget is built again
    //? and the memory will be freed when the widget is disposed again
    //? and the bloc will be created again when the widget is built again
    //? it is the best way to create a bloc it is better than registerInstance
    di.registerFactory<SignInBloc>(() => SignInBloc(get()));
  }
}
