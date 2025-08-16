import '../../../../../base/screens/exports.dart';
import '../../../../common/widgets/custom_text_button.dart';

class DidUserHaveAnAccount extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onTap;
  const DidUserHaveAnAccount({
    super.key,
    required this.onTap,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        firstText,
        style: AppStyles.subtitle.medium().withColor(AppColors.black),
      ),
      CustomTextButton(title: secondText, onTap: onTap),
    ],
  );
}
