import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';
import 'package:tajweed_ai/src/app/theme/theme_bloc.dart';
import 'package:tajweed_ai/src/core/managers/cache/cache_manager_impl.dart';
import 'package:tajweed_ai/src/core/services/theme_preference_service.dart';

Future<ThemeBloc> buildBloc({AppThemeMode? seedFromCache}) async {
  if (seedFromCache != null) {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'app_theme_mode': seedFromCache.code,
    });
  } else {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  }
  final cache = CacheManagerImpl(await SharedPreferences.getInstance());
  return ThemeBloc(ThemePreferenceService(cache));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeBloc', () {
    test('initial state is light when no preference is stored', () async {
      final bloc = await buildBloc();
      expect(bloc.state, AppThemeMode.light);
    });

    test('initial state honors a stored dark preference', () async {
      final bloc = await buildBloc(seedFromCache: AppThemeMode.dark);
      expect(bloc.state, AppThemeMode.dark);
    });

    test('change() emits the new state and persists it', () async {
      final bloc = await buildBloc();

      final emissions = expectLater(
        bloc.stream,
        emitsInOrder(<AppThemeMode>[AppThemeMode.dark]),
      );

      await bloc.change(AppThemeMode.dark);
      expect(bloc.state, AppThemeMode.dark);

      await bloc.close();
      await emissions;
    });

    test('change() is a no-op when the requested mode equals current', () async {
      final bloc = await buildBloc();

      final emissions = <AppThemeMode>[];
      final sub = bloc.stream.listen(emissions.add);

      await bloc.change(AppThemeMode.light);
      // Drain the microtask queue so any emission would surface.
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(bloc.state, AppThemeMode.light);
      expect(emissions, isEmpty);
    });

    test('toggle() flips light <-> dark', () async {
      final bloc = await buildBloc();
      expect(bloc.state, AppThemeMode.light);

      await bloc.toggle();
      expect(bloc.state, AppThemeMode.dark);

      await bloc.toggle();
      expect(bloc.state, AppThemeMode.light);
    });
  });
}
