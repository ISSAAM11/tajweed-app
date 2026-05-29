import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/locale/locale_bloc.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';
import 'package:tajweed_ai/src/app/theme/theme_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';
import 'package:tajweed_ai/src/features/settings/vm/app_language.dart';

import '../base/screens/exports.dart';
import 'router/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
    this.invertOversizedImages = false,
    this.showMaterialGrid = false,
    this.showPerformanceOverlay = false,
  });

  final bool invertOversizedImages;
  final bool showMaterialGrid;
  final bool showPerformanceOverlay;

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = invertOversizedImages;

    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBloc>.value(value: get<LocaleBloc>()),
        BlocProvider<ThemeBloc>.value(value: get<ThemeBloc>()),
        BlocProvider<CheikhCubit>.value(value: get<CheikhCubit>()),
      ],
      child: BlocBuilder<LocaleBloc, AppLanguage>(
        builder: (context, language) => BlocBuilder<ThemeBloc, AppThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            debugShowMaterialGrid: showMaterialGrid,
            showPerformanceOverlay: showPerformanceOverlay,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: themeMode == AppThemeMode.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            locale: Locale(language.code),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
