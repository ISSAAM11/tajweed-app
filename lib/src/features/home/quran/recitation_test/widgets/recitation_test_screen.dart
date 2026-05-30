import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

import '../binding/recitation_test_deps.dart';
import '../data/models/recitation_word.dart';
import '../data/models/word_verdict_model.dart';
import '../vm/recitation_test_bloc.dart';
import 'recitation_word_chip.dart';

class RecitationTestScreen
    extends Feature<RecitationTestBloc, RecitationTestState> {
  RecitationTestScreen({super.key})
    : super(dependencies: RecitationTestDeps().inject);

  @override
  Widget build(BuildContext context, RecitationTestState state) {
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
              l10n.recitationTestTitle,
              style: AppFonts.nunito
                  .withSize(FontSizes.headline3)
                  .withColor(AppColors.scaffold)
                  .semiBold(),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppMetrics.scaffold.horizontalBodyPadding,
            vertical: AppMetrics.spacing.md,
          ),
          child: switch (state) {
            RecitationError(:final reasonKey) => _ErrorBody(
              message: _resolveReason(l10n, reasonKey),
              onRetry: bloc.reset,
              scheme: scheme,
              l10n: l10n,
            ),
            Idle(:final words) when words.isEmpty => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            Idle(:final words, :final verdicts) => _SessionBody(
              words: words,
              verdicts: verdicts,
              listening: false,
              bloc: bloc,
              scheme: scheme,
              l10n: l10n,
              hasResults: verdicts.isNotEmpty,
            ),
            Listening(:final words, :final verdicts) => _SessionBody(
              words: words,
              verdicts: verdicts,
              listening: true,
              bloc: bloc,
              scheme: scheme,
              l10n: l10n,
              hasResults: false,
            ),
          },
        ),
      ),
    );
  }

  String _resolveReason(AppLocalizations l10n, String key) => switch (key) {
    'recitationMicDenied' => l10n.recitationMicDenied,
    _ => l10n.recitationConnectionError,
  };
}

class _SessionBody extends StatelessWidget {
  final List<RecitationWord> words;
  final Map<int, WordVerdictModel> verdicts;
  final bool listening;
  final bool hasResults;
  final RecitationTestBloc bloc;
  final ColorScheme scheme;
  final AppLocalizations l10n;

  const _SessionBody({
    required this.words,
    required this.verdicts,
    required this.listening,
    required this.hasResults,
    required this.bloc,
    required this.scheme,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          listening ? l10n.recitationListening : l10n.recitationInstruction,
          textAlign: TextAlign.center,
          style: AppFonts.lato
              .withSize(FontSizes.subtitle)
              .withColor(
                listening ? AppColors.primary : scheme.onSurfaceVariant,
              )
              .medium(),
        ),
        SizedBox(height: AppMetrics.spacing.md),
        Expanded(
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: AppMetrics.spacing.sm,
                runSpacing: AppMetrics.spacing.sm,
                children: [
                  for (var i = 0; i < words.length; i++)
                    RecitationWordChip(
                      glyph: words[i].glyph,
                      verdict: verdicts[i],
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: AppMetrics.spacing.md),
        _ActionButton(
          listening: listening,
          hasResults: hasResults,
          bloc: bloc,
          l10n: l10n,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final bool listening;
  final bool hasResults;
  final RecitationTestBloc bloc;
  final AppLocalizations l10n;

  const _ActionButton({
    required this.listening,
    required this.hasResults,
    required this.bloc,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final (label, icon, onPressed) = switch ((listening, hasResults)) {
      (true, _) => (l10n.recitationStop, Icons.stop_rounded, bloc.stop),
      (false, true) => (
        l10n.recitationTryAgain,
        Icons.refresh_rounded,
        bloc.reset,
      ),
      (false, false) => (
        l10n.recitationStart,
        Icons.mic_rounded,
        bloc.start,
      ),
    };

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final ColorScheme scheme;
  final AppLocalizations l10n;

  const _ErrorBody({
    required this.message,
    required this.onRetry,
    required this.scheme,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, color: AppColors.error, size: 48),
          SizedBox(height: AppMetrics.spacing.sm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(scheme.onSurface),
          ),
          SizedBox(height: AppMetrics.spacing.md),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(l10n.recitationTryAgain),
          ),
        ],
      ),
    );
  }
}
