import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/features/home/screen/vm/home_screen_bloc.dart';

class HomeScreenDependencies implements Dependencies {
  @override
  void inject() {
    di.registerLazySingleton<HomeScreenBloc>(() => HomeScreenBloc(get()));
  }
}
