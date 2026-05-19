import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/locale/locale_bloc.dart';
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

    return BlocProvider<LocaleBloc>.value(
      value: get<LocaleBloc>(),
      child: BlocBuilder<LocaleBloc, AppLanguage>(
        builder: (context, language) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: showMaterialGrid,
          showPerformanceOverlay: showPerformanceOverlay,
          theme: AppThemes.light,
          locale: Locale(language.code),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: router,
        ),
      ),
    );
  }
}
