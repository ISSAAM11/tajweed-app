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
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: platform == 'Google'
                  ? Colors.red
                  : platform == "Apple"
                  ? scheme.onSurface
                  : Colors.blue,
            ),
          ],
        )
        .onTap(onTap)
        .decorate(
          height: AppMetrics.buttons.elevated.height,
          width: (MediaQuery.sizeOf(context).width / 4),
          decoration: BoxDecoration(
            border: Border.all(color: scheme.outlineVariant, width: 1),
            borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
          ),
        );
  }
}
