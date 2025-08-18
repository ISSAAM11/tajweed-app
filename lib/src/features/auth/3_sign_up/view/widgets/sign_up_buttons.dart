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
  Widget build(BuildContext context) => Observer(
    observes: index,
    builder: (BuildContext context, index) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (index == 1) ...[
          OutlinedLoadingButton(
            title: 'Previous',
            onTap: onPrevious ?? () {},
            titleFontSize: FontSizes.title,
            height: AppMetrics.buttons.elevated.height,
          ).expanded(),
          const HorizontalSpacing(10),
        ],
        LoadingButton(
          title: index == 0
              ? 'Next'
              : index == 1
              ? 'Sign Up'
              : 'Verify',
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
