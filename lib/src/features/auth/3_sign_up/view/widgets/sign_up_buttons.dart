part of 'sign_up_form.dart';

class _Actions extends StatelessWidget {
  final Observable<int> index;
  final VoidCallback? onPrevious;
  final VoidCallback onNext;
  final bool isLoading;

  const _Actions({
    super.key,
    this.onPrevious,
    required this.onNext,
    required this.index,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Observer(
      observes: index,
      builder: (BuildContext context, index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (index == 1) ...[
            OutlinedLoadingButton(
              title: l10n.authPrevious,
              onTap: onPrevious ?? () {},
              titleFontSize: FontSizes.title,
              height: AppMetrics.buttons.elevated.height,
            ).expanded(),
            const HorizontalSpacing(10),
          ],
          LoadingButton(
            title: index == 0
                ? l10n.authNext
                : index == 1
                ? l10n.authSignUp
                : l10n.authActivate,
            onTap: onNext,
            isLoading: isLoading,
            titleFontSize: FontSizes.title,
            height: AppMetrics.buttons.elevated.height,
            useGradient: true,
          ).expanded(),
        ],
      ),
    );
  }
}
