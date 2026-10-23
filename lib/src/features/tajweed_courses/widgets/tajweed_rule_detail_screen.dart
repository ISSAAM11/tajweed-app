import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

import '../binding/tajweed_rule_detail_deps.dart';
import '../data/models/tajweed_example.dart';
import '../data/models/tajweed_rule.dart';
import '../data/repository/tajweed_rules_repository.dart';
import '../vm/tajweed_rule_detail_bloc.dart';



class TajweedRuleDetailScreen
    extends Feature<TajweedRuleDetailBloc, TajweedRuleDetailState> {
  TajweedRuleDetailScreen({required String ruleId, super.key})
    : super(
        dependencies: TajweedRuleDetailDeps(ruleId: ruleId).inject,
      );

  static const _repo = TajweedRulesRepository();

  @override
  Widget build(BuildContext context, TajweedRuleDetailState state) {
    final ruleId = bloc.ruleId;
    final rule = _repo.byId(ruleId);
    if (rule == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final playingState = state is Playing ? state : null;

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
              _resolveTitle(l10n, rule.titleKey),
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
            _RuleHeader(rule: rule, l10n: l10n, scheme: scheme),
            SizedBox(height: AppMetrics.spacing.md),
            if (rule.examples.isNotEmpty) ...[
              Text(
                l10n.tajweedRuleExamplesSection,
                style: AppFonts.lato
                    .withSize(FontSizes.title)
                    .withColor(scheme.onSurface)
                    .semiBold(),
              ),
              SizedBox(height: AppMetrics.spacing.sm),
              for (final example in rule.examples) ...[
                _ExampleCard(
                  example: example,
                  isPlaying: playingState?.exampleId == example.id,
                  l10n: l10n,
                  scheme: scheme,
                  onPlayTap: () {
                    if (example.audioAsset != null) {
                      bloc.playExample(example.id, example.audioAsset!);
                    }
                  },
                ),
                SizedBox(height: AppMetrics.spacing.sm),
              ],
            ],
          ],
        ),
      ),
    );
  }

  String _resolveTitle(AppLocalizations l10n, String key) =>
      switch (key) {
        'tajweedRuleMaddTitle' => l10n.tajweedRuleMaddTitle,
        'tajweedRuleGhunnahTitle' => l10n.tajweedRuleGhunnahTitle,
        'tajweedRuleIdghamTitle' => l10n.tajweedRuleIdghamTitle,
        'tajweedRuleIdghamShafawyTitle' => l10n.tajweedRuleIdghamShafawyTitle,
        'tajweedRuleIkhfaTitle' => l10n.tajweedRuleIkhfaTitle,
        'tajweedRuleIqlabTitle' => l10n.tajweedRuleIqlabTitle,
        'tajweedRuleQalqalaTitle' => l10n.tajweedRuleQalqalaTitle,
        _ => key,
      };
}

class _RuleHeader extends StatelessWidget {
  final TajweedRule rule;
  final AppLocalizations l10n;
  final ColorScheme scheme;

  const _RuleHeader({
    required this.rule,
    required this.l10n,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    final longDesc = _resolveLongDesc(l10n, rule.longDescriptionKey);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          longDesc,
          style: AppFonts.lato
              .withSize(FontSizes.subtitle)
              .withColor(scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  String _resolveLongDesc(AppLocalizations l10n, String key) =>
      switch (key) {
        'tajweedRuleMaddLongDescription' => l10n.tajweedRuleMaddLongDescription,
        'tajweedRuleGhunnahLongDescription' =>
          l10n.tajweedRuleGhunnahLongDescription,
        'tajweedRuleIdghamLongDescription' =>
          l10n.tajweedRuleIdghamLongDescription,
        'tajweedRuleIdghamShafawyLongDescription' =>
          l10n.tajweedRuleIdghamShafawyLongDescription,
        'tajweedRuleIkhfaLongDescription' =>
          l10n.tajweedRuleIkhfaLongDescription,
        'tajweedRuleIqlabLongDescription' =>
          l10n.tajweedRuleIqlabLongDescription,
        'tajweedRuleQalqalaLongDescription' =>
          l10n.tajweedRuleQalqalaLongDescription,
        _ => key,
      };
}

class _ExampleCard extends StatelessWidget {
  final TajweedExample example;
  final bool isPlaying;
  final AppLocalizations l10n;
  final ColorScheme scheme;
  final VoidCallback onPlayTap;

  const _ExampleCard({
    required this.example,
    required this.isPlaying,
    required this.l10n,
    required this.scheme,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final reference = _resolveKey(l10n, example.referenceKey);
    final transliteration = _resolveKey(l10n, example.transliterationKey);
    final explanation = _resolveKey(l10n, example.explanationKey);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    example.arabicText,
                    style: AppFonts.uthmanicHafsFont
                        .withSize(FontSizes.headline2)
                        .withColor(AppColors.primary),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              if (example.audioAsset != null) ...[
                const SizedBox(width: 12),
                _PlayButton(isPlaying: isPlaying, onTap: onPlayTap),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reference,
            style: AppFonts.lato
                .withSize(FontSizes.caption)
                .withColor(scheme.onSurfaceVariant)
                .medium(),
          ),
          const SizedBox(height: 6),
          Text(
            transliteration,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(scheme.onSurface)
                .medium(),
          ),
          const SizedBox(height: 6),
          Text(
            explanation,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  String _resolveKey(AppLocalizations l10n, String key) =>
      switch (key) {
        'tajweedRuleMaddExample1Reference' =>
          l10n.tajweedRuleMaddExample1Reference,
        'tajweedRuleMaddExample1Transliteration' =>
          l10n.tajweedRuleMaddExample1Transliteration,
        'tajweedRuleMaddExample1Explanation' =>
          l10n.tajweedRuleMaddExample1Explanation,
        'tajweedRuleMaddExample2Reference' =>
          l10n.tajweedRuleMaddExample2Reference,
        'tajweedRuleMaddExample2Transliteration' =>
          l10n.tajweedRuleMaddExample2Transliteration,
        'tajweedRuleMaddExample2Explanation' =>
          l10n.tajweedRuleMaddExample2Explanation,
        'tajweedRuleGhunnahExample1Reference' =>
          l10n.tajweedRuleGhunnahExample1Reference,
        'tajweedRuleGhunnahExample1Transliteration' =>
          l10n.tajweedRuleGhunnahExample1Transliteration,
        'tajweedRuleGhunnahExample1Explanation' =>
          l10n.tajweedRuleGhunnahExample1Explanation,
        'tajweedRuleGhunnahExample2Reference' =>
          l10n.tajweedRuleGhunnahExample2Reference,
        'tajweedRuleGhunnahExample2Transliteration' =>
          l10n.tajweedRuleGhunnahExample2Transliteration,
        'tajweedRuleGhunnahExample2Explanation' =>
          l10n.tajweedRuleGhunnahExample2Explanation,
        'tajweedRuleIdghamExample1Reference' =>
          l10n.tajweedRuleIdghamExample1Reference,
        'tajweedRuleIdghamExample1Transliteration' =>
          l10n.tajweedRuleIdghamExample1Transliteration,
        'tajweedRuleIdghamExample1Explanation' =>
          l10n.tajweedRuleIdghamExample1Explanation,
        'tajweedRuleIdghamExample2Reference' =>
          l10n.tajweedRuleIdghamExample2Reference,
        'tajweedRuleIdghamExample2Transliteration' =>
          l10n.tajweedRuleIdghamExample2Transliteration,
        'tajweedRuleIdghamExample2Explanation' =>
          l10n.tajweedRuleIdghamExample2Explanation,
        'tajweedRuleIdghamShafawyExample1Reference' =>
          l10n.tajweedRuleIdghamShafawyExample1Reference,
        'tajweedRuleIdghamShafawyExample1Transliteration' =>
          l10n.tajweedRuleIdghamShafawyExample1Transliteration,
        'tajweedRuleIdghamShafawyExample1Explanation' =>
          l10n.tajweedRuleIdghamShafawyExample1Explanation,
        'tajweedRuleIkhfaExample1Reference' =>
          l10n.tajweedRuleIkhfaExample1Reference,
        'tajweedRuleIkhfaExample1Transliteration' =>
          l10n.tajweedRuleIkhfaExample1Transliteration,
        'tajweedRuleIkhfaExample1Explanation' =>
          l10n.tajweedRuleIkhfaExample1Explanation,
        'tajweedRuleIkhfaExample2Reference' =>
          l10n.tajweedRuleIkhfaExample2Reference,
        'tajweedRuleIkhfaExample2Transliteration' =>
          l10n.tajweedRuleIkhfaExample2Transliteration,
        'tajweedRuleIkhfaExample2Explanation' =>
          l10n.tajweedRuleIkhfaExample2Explanation,
        'tajweedRuleIqlabExample1Reference' =>
          l10n.tajweedRuleIqlabExample1Reference,
        'tajweedRuleIqlabExample1Transliteration' =>
          l10n.tajweedRuleIqlabExample1Transliteration,
        'tajweedRuleIqlabExample1Explanation' =>
          l10n.tajweedRuleIqlabExample1Explanation,
        'tajweedRuleQalqalaExample1Reference' =>
          l10n.tajweedRuleQalqalaExample1Reference,
        'tajweedRuleQalqalaExample1Transliteration' =>
          l10n.tajweedRuleQalqalaExample1Transliteration,
        'tajweedRuleQalqalaExample1Explanation' =>
          l10n.tajweedRuleQalqalaExample1Explanation,
        'tajweedRuleQalqalaExample2Reference' =>
          l10n.tajweedRuleQalqalaExample2Reference,
        'tajweedRuleQalqalaExample2Transliteration' =>
          l10n.tajweedRuleQalqalaExample2Transliteration,
        'tajweedRuleQalqalaExample2Explanation' =>
          l10n.tajweedRuleQalqalaExample2Explanation,
        _ => key,
      };
}

class _PlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTap;

  const _PlayButton({required this.isPlaying, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isPlaying ? AppColors.primary : AppColors.primary.withAlpha(26),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: isPlaying ? Colors.white : AppColors.primary,
          size: 22,
        ),
      ),
    );
  }
}
