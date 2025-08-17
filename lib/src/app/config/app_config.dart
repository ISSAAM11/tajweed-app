import '../../app/environment/app_environment.dart';
import '../../features/auth/export.dart';

abstract final class AppConfig {
  static String _initialRoute = signInRoute.path;

  static String get initialRoute => _initialRoute;

  static void setInitialRoute([String? devRoute]) {
    _initialRoute = AppEnvironment.current == Environment.dev
        ? devRoute ?? signInRoute.path
        : getFirstRoute();
  }

  static String getFirstRoute() => signInRoute.path;
}
