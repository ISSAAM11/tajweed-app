import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

class ComingSoonTile extends StatelessWidget {
  final IconData? icon;
  final String title;

  const ComingSoonTile({super.key, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.comingSoonTile;
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(metrics.rowRadius),
      onTap: () => showComingSoonSnackbar(context),
      child: Container(
        height: metrics.rowHeight,
        padding: metrics.rowPadding,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(metrics.rowRadius),
          border: Border.all(
            color: scheme.outlineVariant,
            width: metrics.rowBorderWidth,
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: scheme.onSurfaceVariant,
                size: metrics.iconSize,
              ),
              SizedBox(width: metrics.iconTextSpacing),
            ],
            Expanded(
              child: Text(
                title,
                style: AppFonts.lato
                    .withSize(FontSizes.title)
                    .withColor(scheme.onSurfaceVariant)
                    .medium(),
              ),
            ),
            Container(
              padding: metrics.badgePadding,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(metrics.badgeRadius),
              ),
              child: Text(
                l10n.comingSoon,
                style: AppFonts.lato
                    .withSize(FontSizes.indication)
                    .withColor(scheme.onSurfaceVariant)
                    .medium(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showComingSoonSnackbar(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  appMessenger.showSnackBar(
    CommonSnackbar(
      message: l10n.comingSoonMessage,
      type: SnackbarType.info,
    ),
  );
}
