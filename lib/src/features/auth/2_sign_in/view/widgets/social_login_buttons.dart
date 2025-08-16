import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/social_login_button.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onFacebookTap;
  const SocialLoginButtons({
    super.key,
    required this.onGoogleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: SocialLoginButton(
          platform: 'Google',
          icon: Icons.g_mobiledata,
          onTap: onGoogleTap,
        ),
      ),
      HorizontalSpacing(AppMetrics.spacing.md),
      Expanded(
        child: SocialLoginButton(
          platform: 'Facebook',
          icon: Icons.facebook,
          onTap: onFacebookTap,
        ),
      ),
    ],
  );
}
