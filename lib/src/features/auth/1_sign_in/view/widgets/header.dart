import '../../../../../base/screens/exports.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) => Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.mosque,
            size: 50,
            color: Colors.white,
          ),
        ),
        VerticalSpacing(AppMetrics.spacing.md),
        Text(
          'Tajweed AI',
          style: AppStyles.headline1.bold().primary(),
        ),
        VerticalSpacing(AppMetrics.spacing.xs),
        Text(
          'Learn Quran with AI',
          style: AppStyles.subtitle.medium().greyRegular(),
        ),
      ],
    );
}