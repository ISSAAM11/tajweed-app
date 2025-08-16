import '../../../base/screens/exports.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const CustomTextButton({
    super.key, 
    required this.title, 
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) => Text(
          title,
          style: AppStyles.subtitle.medium().primary(),
        ).asIconButton(
        onTap: onTap,
      );
}