import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/tajweed_test/binding/tajweed_test_deps.dart';
import 'package:tajweed_ai/src/features/home/tajweed_test/vm/tajweed_test_bloc.dart';

/// Tajweed test: the user recites a short ayah showcasing one rule, the audio
/// is transcribed by a Quran-finetuned ASR model and scored against the
/// expected text.
final class TajweedTestScreen extends Feature<TajweedTestBloc, TajweedTestState> {
  TajweedTestScreen({super.key})
      : super(dependencies: TajweedTestDependencies().inject);

  @override
  Widget build(BuildContext context, TajweedTestState state) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<TajweedTestBloc>();

    return Scaffold(
      backgroundColor: AppColors.scaffold,
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
              l10n.homeTajweedTest,
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
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppMetrics.spacing.md),
              Text(
                '${state.index + 1} / ${state.total}',
                textAlign: TextAlign.center,
                style: AppFonts.lato
                    .withSize(FontSizes.subtitle)
                    .withColor(AppColors.greyRegular),
              ),
              SizedBox(height: AppMetrics.spacing.xs),
              Text(
                _ruleTitle(l10n, state.item.ruleKey),
                textAlign: TextAlign.center,
                style: AppFonts.nunito
                    .withSize(FontSizes.headline4)
                    .withColor(AppColors.primaryDark)
                    .semiBold(),
              ),
              SizedBox(height: AppMetrics.spacing.md),
              Container(
                padding: EdgeInsets.all(AppMetrics.spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius:
                      BorderRadius.circular(AppMetrics.spacing.sm),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Text(
                  state.item.displayText,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: AppFonts.uthmanicHafsFont
                      .withSize(FontSizes.headline1)
                      .withColor(AppColors.greyDarkest),
                ),
              ),
              SizedBox(height: AppMetrics.spacing.sm),
              Text(
                l10n.tajweedTestInstruction,
                textAlign: TextAlign.center,
                style: AppFonts.lato
                    .withSize(FontSizes.subtitle)
                    .withColor(AppColors.greyMedium),
              ),
              const Spacer(),
              ..._body(context, l10n, state, bloc),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _body(
    BuildContext context,
    AppLocalizations l10n,
    TajweedTestState state,
    TajweedTestBloc bloc,
  ) {
    switch (state) {
      case TajweedTestReady():
        return [
          _MicButton(
            icon: Icons.mic,
            color: AppColors.primary,
            onTap: () => bloc.add(const StartRecording()),
          ),
          SizedBox(height: AppMetrics.spacing.xs),
          Text(
            l10n.tajweedTestRecord,
            textAlign: TextAlign.center,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(AppColors.greyMedium),
          ),
        ];
      case TajweedTestRecording():
        return [
          _MicButton(
            icon: Icons.stop,
            color: AppColors.error,
            onTap: () => bloc.add(const StopAndEvaluate()),
          ),
          SizedBox(height: AppMetrics.spacing.xs),
          Text(
            l10n.tajweedTestStop,
            textAlign: TextAlign.center,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(AppColors.greyMedium),
          ),
        ];
      case TajweedTestEvaluating():
        return [
          const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          SizedBox(height: AppMetrics.spacing.sm),
          Text(
            l10n.tajweedTestEvaluating,
            textAlign: TextAlign.center,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(AppColors.greyMedium),
          ),
        ];
      case TajweedTestResult(:final score, :final transcript, :final accepted):
        final color = accepted ? AppColors.success : AppColors.error;
        return [
          Icon(
            accepted ? Icons.check_circle : Icons.cancel,
            color: color,
            size: AppMetrics.spacing.xl,
          ),
          SizedBox(height: AppMetrics.spacing.xs),
          Text(
            l10n.tajweedTestScore((score * 100).round()),
            textAlign: TextAlign.center,
            style: AppFonts.nunito
                .withSize(FontSizes.headline2)
                .withColor(color)
                .semiBold(),
          ),
          SizedBox(height: AppMetrics.spacing.xs),
          Text(
            accepted ? l10n.tajweedTestAccepted : l10n.tajweedTestRejected,
            textAlign: TextAlign.center,
            style: AppFonts.lato
                .withSize(FontSizes.title)
                .withColor(AppColors.greyDarkest),
          ),
          SizedBox(height: AppMetrics.spacing.xs),
          Text(
            '${l10n.tajweedTestYouSaid} $transcript',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(AppColors.greyRegular),
          ),
          SizedBox(height: AppMetrics.spacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => bloc.add(const RetryTest()),
                child: Text(l10n.recitationTryAgain),
              ),
              SizedBox(width: AppMetrics.spacing.sm),
              ElevatedButton(
                onPressed: () => bloc.add(const NextTest()),
                child: Text(l10n.tajweedTestNext),
              ),
            ],
          ),
        ];
      case TajweedTestError(:final messageKey):
        return [
          Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: AppMetrics.spacing.xl,
          ),
          SizedBox(height: AppMetrics.spacing.xs),
          Text(
            _resolveError(l10n, messageKey),
            textAlign: TextAlign.center,
            style: AppFonts.lato
                .withSize(FontSizes.subtitle)
                .withColor(AppColors.greyDarkest),
          ),
          SizedBox(height: AppMetrics.spacing.md),
          Center(
            child: ElevatedButton(
              onPressed: () => bloc.add(const RetryTest()),
              child: Text(l10n.recitationTryAgain),
            ),
          ),
        ];
    }
  }
}

class _MicButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MicButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: color,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(AppMetrics.spacing.md),
            child: Icon(
              icon,
              color: AppColors.scaffold,
              size: AppMetrics.spacing.lg,
            ),
          ),
        ),
      ),
    );
  }
}

String _ruleTitle(AppLocalizations l10n, String ruleKey) => switch (ruleKey) {
      'qalqala' => l10n.tajweedRuleQalqalaTitle,
      'idgham' => l10n.tajweedRuleIdghamTitle,
      'ikhfa' => l10n.tajweedRuleIkhfaTitle,
      'ghunnah' => l10n.tajweedRuleGhunnahTitle,
      _ => ruleKey,
    };

String _resolveError(AppLocalizations l10n, String key) => switch (key) {
      'recitationMicDenied' => l10n.recitationMicDenied,
      'tajweedTestModelLoading' => l10n.tajweedTestModelLoading,
      'tajweedTestEvalError' => l10n.tajweedTestEvalError,
      _ => '${l10n.errorPrefix}: $key',
    };
