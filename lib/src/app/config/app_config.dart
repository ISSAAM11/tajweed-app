import 'package:tajweed_ai/src/features/auth/export.dart';

import '../../features/home/screen/router/home_screen_route.dart';

abstract final class AppConfig {
  static late String _initialRoute;

  static String get initialRoute => _initialRoute;

  static Future<void> setInitialRoute([String? devRoute]) async {
    _initialRoute = devRoute ?? signInRoute.path;
  }
}
