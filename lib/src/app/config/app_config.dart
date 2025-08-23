import 'package:shared_preferences/shared_preferences.dart';
import '../../core/managers/cache/cache_manager_impl.dart';
import '../../app/binding/app_bindings.dart';
import 'package:cg_core_defs/cg_core_defs.dart';

import '../../features/auth/export.dart';

abstract final class AppConfig {
  static late String _initialRoute;

  static String get initialRoute => _initialRoute;

  static Future<void> setInitialRoute([String? devRoute]) async {
    _initialRoute = devRoute ?? await _setFirstRoute();
  }

  static Future<String> _setFirstRoute() async {
    try {
      final cacheManager =
          get<CacheManager<SharedPreferences>>() as CacheManagerImpl;
      final [accessToken, refreshToken] = await Future.wait([
        cacheManager.getSecureString('access_token'),
        cacheManager.getSecureString('refresh_token'),
      ]);
      Debugger.red(accessToken);
      Debugger.green(refreshToken);

      return (accessToken != null && refreshToken != null)
          ? signUpRoute.path
          : signInRoute.path;
    } catch (e) {
      Debugger.red(e.toString());
      return signInRoute.path;
    }
  }
}
