import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final metrics = AppMetrics.settingsScreen;

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
              l10n.myAccountTitle,
              style: AppFonts.nunito
                  .withSize(FontSizes.headline3)
                  .withColor(AppColors.scaffold)
                  .semiBold(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: metrics.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProfileHeader(),
            SizedBox(height: AppMetrics.spacing.lg),
            _SectionTitle(label: l10n.myAccountComingSoonSection),
            ComingSoonTile(
              icon: Icons.lock_outline_rounded,
              title: l10n.myAccountChangePassword,
            ),
            SizedBox(height: metrics.optionGap),
            ComingSoonTile(
              icon: Icons.account_circle_outlined,
              title: l10n.myAccountAvatar,
            ),
            SizedBox(height: metrics.optionGap),
            ComingSoonTile(
              icon: Icons.link_rounded,
              title: l10n.myAccountLinkedAccounts,
            ),
            SizedBox(height: AppMetrics.spacing.lg),
            _SignOutButton(),
            SizedBox(height: AppMetrics.spacing.md),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: scheme.surfaceContainerHigh,
          child: Icon(
            Icons.person_outline_rounded,
            color: scheme.onSurfaceVariant,
            size: 56,
          ),
        ),
        SizedBox(height: AppMetrics.spacing.sm),
        Text(
          l10n.settingsGuestLabel,
          style: AppFonts.lato
              .withSize(FontSizes.headline3)
              .withColor(scheme.onSurface)
              .semiBold(),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.settingsGuestSubtitle,
          style: AppFonts.lato
              .withSize(FontSizes.subtitle)
              .withColor(scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String label;

  const _SectionTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppMetrics.settingsScreen.sectionTitlePadding,
      child: Text(
        label,
        style: AppFonts.lato
            .withSize(FontSizes.subtitle)
            .withColor(Theme.of(context).colorScheme.onSurfaceVariant)
            .semiBold(),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final metrics = AppMetrics.settingsScreen;

    return InkWell(
      borderRadius: BorderRadius.circular(metrics.optionRowRadius),
      onTap: () => _confirmSignOut(context),
      child: Container(
        height: metrics.optionRowHeight,
        padding: metrics.optionRowPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(metrics.optionRowRadius),
          border: Border.all(
            color: scheme.error,
            width: metrics.optionRowBorderWidth,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: scheme.error,
              size: metrics.selectionIconSize,
            ),
            SizedBox(width: AppMetrics.spacing.xs),
            Text(
              l10n.myAccountSignOut,
              style: AppFonts.lato
                  .withSize(FontSizes.title)
                  .withColor(scheme.error)
                  .semiBold(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: scheme.surfaceContainerHigh,
        title: Text(
          l10n.myAccountSignOutConfirmTitle,
          style: AppFonts.lato
              .withSize(FontSizes.title)
              .withColor(scheme.onSurface)
              .semiBold(),
        ),
        content: Text(
          l10n.myAccountSignOutConfirmMessage,
          style: AppFonts.lato
              .withSize(FontSizes.subtitle)
              .withColor(scheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              l10n.myAccountSignOutCancel,
              style: AppFonts.lato
                  .withSize(FontSizes.subtitle)
                  .withColor(scheme.onSurfaceVariant)
                  .medium(),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.myAccountSignOut,
              style: AppFonts.lato
                  .withSize(FontSizes.subtitle)
                  .withColor(scheme.error)
                  .semiBold(),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await get<FlutterSecureStorage>().deleteAll();
      if (context.mounted) {
        context.go('/sign-in');
      }
    }
  }
}
