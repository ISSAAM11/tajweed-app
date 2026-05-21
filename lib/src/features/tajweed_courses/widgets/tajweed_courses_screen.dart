import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

class TajweedCoursesScreen extends StatelessWidget {
  const TajweedCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final rules = _rules(l10n);

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
              l10n.tajweedCoursesTitle,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.tajweedCoursesIntro,
              style: AppFonts.lato
                  .withSize(FontSizes.subtitle)
                  .withColor(scheme.onSurfaceVariant),
            ),
            SizedBox(height: AppMetrics.spacing.md),
            for (final rule in rules) ...[
              _RuleCard(title: rule.title, description: rule.description),
              SizedBox(height: AppMetrics.spacing.sm),
            ],
            SizedBox(height: AppMetrics.spacing.xs),
            ComingSoonTile(
              icon: Icons.school_outlined,
              title: l10n.tajweedCoursesInteractive,
            ),
          ],
        ),
      ),
    );
  }

  List<_Rule> _rules(AppLocalizations l10n) => [
    _Rule(l10n.tajweedRuleMaddTitle, l10n.tajweedRuleMaddDescription),
    _Rule(l10n.tajweedRuleGhunnahTitle, l10n.tajweedRuleGhunnahDescription),
    _Rule(l10n.tajweedRuleIdghamTitle, l10n.tajweedRuleIdghamDescription),
    _Rule(l10n.tajweedRuleIkhfaTitle, l10n.tajweedRuleIkhfaDescription),
    _Rule(l10n.tajweedRuleIqlabTitle, l10n.tajweedRuleIqlabDescription),
    _Rule(l10n.tajweedRuleQalqalaTitle, l10n.tajweedRuleQalqalaDescription),
  ];
}

class _Rule {
  final String title;
  final String description;
  const _Rule(this.title, this.description);
}

class _RuleCard extends StatelessWidget {
  final String title;
  final String description;

  const _RuleCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.lato
                .withSize(FontSizes.title)
                .withColor(scheme.onSurface)
                .semiBold(),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
