import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/custom_text_button.dart';

class DontHaveAccount extends StatelessWidget {
  final VoidCallback onTap;
  const DontHaveAccount({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) =>  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an Account? ",
              style: AppStyles.subtitle.medium().withColor(AppColors.black),
            ),
            CustomTextButton(
              title: "create one",
              onTap: onTap,
            ),
          ],
        );
}


