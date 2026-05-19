import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';
import 'package:tajweed_ai/src/core/managers/cache/cache_manager_impl.dart';
import 'package:tajweed_ai/src/core/services/theme_preference_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CacheManagerImpl cache;
  late ThemePreferenceService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    cache = CacheManagerImpl(await SharedPreferences.getInstance());
    service = ThemePreferenceService(cache);
  });

  group('ThemePreferenceService', () {
    test('returns AppThemeMode.light when no preference is stored', () {
      expect(service.get(), AppThemeMode.light);
    });

    test('persists and returns AppThemeMode.dark after set()', () async {
      await service.set(AppThemeMode.dark);
      expect(service.get(), AppThemeMode.dark);
    });

    test('round-trips through cache (no in-memory shortcut)', () async {
      await service.set(AppThemeMode.dark);

      final freshCache = CacheManagerImpl(await SharedPreferences.getInstance());
      final freshService = ThemePreferenceService(freshCache);

      expect(freshService.get(), AppThemeMode.dark);
    });

    test('switching from dark back to light persists', () async {
      await service.set(AppThemeMode.dark);
      await service.set(AppThemeMode.light);
      expect(service.get(), AppThemeMode.light);
    });
  });
}
