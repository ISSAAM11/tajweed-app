import '../../../base/screens/exports.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) =>  Row(
    children: [
      Divider(color: Colors.black26).expanded(),
      Text(
        'Or',
        style: AppStyles.subtitle.medium().withColor(AppColors.greyRegular),
      ).symmetricPadding(horizontal: 16),
      Divider(color: Colors.black26).expanded(),
    ],
  );
}
