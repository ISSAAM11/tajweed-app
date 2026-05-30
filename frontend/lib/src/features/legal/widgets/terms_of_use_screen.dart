import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            backgroundColor: AppColors.greyDarkest,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back, color: AppColors.scaffold),
            ),
            title: Text(
              l10n.termsOfUseTitle,
              style: AppFonts.nunito
                  .withSize(FontSizes.headline3)
                  .withColor(AppColors.scaffold)
                  .semiBold(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Text(
          l10n.termsOfUseBody,
          style: AppFonts.lato
              .withSize(FontSizes.subtitle)
              .withColor(scheme.onSurface),
        ),
      ),
    );
  }
}
