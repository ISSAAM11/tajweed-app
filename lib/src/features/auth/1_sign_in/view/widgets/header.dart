import '../../../../../base/screens/exports.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) =>Column(
      children: [
        Icon(
            Icons.mosque,
            size: 40,
            color: AppColors.primary,
          ).decorate(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          ),
        VerticalSpacing(AppMetrics.spacing.sm),
        Text(
          'Tajweed AI',
          style: AppStyles.headline1.bold().primary(),
        ),
        Text(
          'Learn Quran with AI',
          style: AppStyles.subtitle.medium().withColor(AppColors.greyRegular),
        ),
      ],
    );
}