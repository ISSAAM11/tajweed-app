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
  Widget build(BuildContext context) =>
      Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: platform == 'Google'
                    ? Colors.red
                    : platform == "Apple"
                    ? AppColors.greyMedium
                    : Colors.blue,
              ),
            ],
          )
          .onTap(onTap)
          .decorate(
            height: AppMetrics.buttons.elevated.height,
            width: AppMetrics.buttons.elevated.width - 20,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider, width: 1),
              borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
            ),
          );
}
