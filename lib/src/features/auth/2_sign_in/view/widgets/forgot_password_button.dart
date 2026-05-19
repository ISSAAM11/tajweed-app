import 'package:tajweed_ai/l10n/app_localizations.dart';

import '../../../../common/widgets/custom_text_button.dart';
import '../../../../../base/screens/exports.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPasswordButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Spacer(),
      CustomTextButton(
        title: AppLocalizations.of(context)!.authForgotPassword,
        onTap: onTap,
        textColor: AppColors.primary,
      ),
    ],
  ).symmetricPadding(vertical: 8);
}
