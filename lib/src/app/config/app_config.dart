import '../../app/environment/app_environment.dart';
import '../../features/auth/export.dart';

abstract final class AppConfig {
  static late String _initialRoute;

  static String get initialRoute => _initialRoute;

  static void setInitialRoute([String? devRoute]) {
    _initialRoute = AppEnvironment.current == Environment.dev
        ? devRoute ?? signInRoute.path
        : _getFirstRoute();
  }

  static String _getFirstRoute() => signInRoute.path;
}
