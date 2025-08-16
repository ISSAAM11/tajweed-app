import '../../../base/screens/exports.dart';

class SocialLoginButton extends StatelessWidget {
  final String platform;
  final IconData icon;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.platform,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) =>    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: platform == 'Google' ? Colors.red : Colors.blue,
        ),
        HorizontalSpacing(AppMetrics.spacing.xs),
        Text(
          platform,
          style: AppStyles.subtitle.medium().withColor(AppColors.greyRegular),
        ),
      ],
    )
      .onTap(onTap)
      .decorate(
         height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
        ),

      );
}