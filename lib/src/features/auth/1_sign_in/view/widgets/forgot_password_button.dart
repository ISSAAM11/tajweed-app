import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_text_button.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPasswordButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) =>  Row(
    children: [
      const Spacer(),
      CustomTextButton(
        title: 'Forgot Password?',
        onTap: onTap,
      ),
    ],
  );
}