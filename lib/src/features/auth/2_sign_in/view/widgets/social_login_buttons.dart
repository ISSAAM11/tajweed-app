import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/social_login_button.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onAppleTap;
  const SocialLoginButtons({
    super.key,
    required this.onGoogleTap,
    required this.onFacebookTap,
    required this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SocialLoginButton(
        platform: 'Google',
        icon: Icons.g_mobiledata,
        onTap: onGoogleTap,
      ),

      SocialLoginButton(
        platform: 'Facebook',
        icon: Icons.facebook,
        onTap: onFacebookTap,
      ),

      SocialLoginButton(
        platform: 'Apple',
        icon: Icons.apple,
        onTap: onAppleTap,
      ),
    ],
  );
}
