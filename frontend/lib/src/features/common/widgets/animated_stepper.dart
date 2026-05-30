import '../../../base/screens/exports.dart';

class AnimatedStepper extends StatelessWidget {
  final int length;
  final Observable<int> currentStep;

  const AnimatedStepper({
    super.key,
    required this.length,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Observer(
      observes: currentStep,
      builder: (BuildContext context, currentStep) => Row(
        children: List.generate(length * 2 - 1, (index) {
          if (index.isEven) {
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: AppMetrics.scaffold.horizontalBodyPadding * 1.2,
              height: AppMetrics.scaffold.horizontalBodyPadding * 1.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCompleted
                      ? AppColors
                            .primaryDark // active border (brand)
                      : scheme.outlineVariant, // inactive border
                  width: 2,
                ),
                color: isCompleted
                    ? AppColors.primaryLight
                    : scheme.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: AppMetrics.scaffold.horizontalBodyPadding / 1.3,
                      )
                    : Text(
                        "${stepIndex + 1}",
                        style: AppStyles.indication.semiBold().copyWith(color: scheme.onSurfaceVariant),
                      ),
              ),
            );
          } else {
            final lineIndex = (index - 1) ~/ 2;
            final isActive = lineIndex < currentStep;

            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryLight
                      : scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }
        }),
      ).symmetricPadding(horizontal: AppMetrics.scaffold.topBodyPadding),
    );
  }
}
