import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/binding/app_bindings.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';
import 'package:tajweed_ai/src/app/theme/theme_bloc.dart';
import 'package:tajweed_ai/src/core/managers/cache/cache_manager_impl.dart';
import 'package:tajweed_ai/src/core/services/theme_preference_service.dart';
import 'package:tajweed_ai/src/features/settings/widgets/settings_screen.dart';

Future<void> _registerThemeBloc() async {
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final cache = CacheManagerImpl(await SharedPreferences.getInstance());
  if (di.isRegistered<ThemeBloc>()) {
    di.unregister<ThemeBloc>();
  }
  di.registerSingleton<ThemeBloc>(
    ThemeBloc(ThemePreferenceService(cache)),
  );
}

Widget _wrap(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(_registerThemeBloc);

  tearDown(() async {
    if (di.isRegistered<ThemeBloc>()) {
      di.unregister<ThemeBloc>();
    }
  });

  group('Settings — theme section', () {
    testWidgets('renders Light and Dark labels in English', (tester) async {
      await tester.pumpWidget(_wrap(const _ThemeSectionHarness()));
      await tester.pump();

      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
    });

    testWidgets('tapping Dark switches ThemeBloc state', (tester) async {
      await tester.pumpWidget(_wrap(const _ThemeSectionHarness()));
      await tester.pump();

      expect(get<ThemeBloc>().state, AppThemeMode.light);

      await tester.tap(find.text('Dark'));
      await tester.pump();

      expect(get<ThemeBloc>().state, AppThemeMode.dark);
    });
  });
}

/// Harness that builds just the theme section in isolation. The real
/// SettingsScreen needs the full SettingsBloc + LocaleBloc DI chain; for
/// this widget test we only care about the theme rows.
class _ThemeSectionHarness extends StatelessWidget {
  const _ThemeSectionHarness();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SettingsAppearanceSection());
  }
}
