import 'package:tajweed_ai/l10n/app_localizations.dart';

import '../../../../../base/screens/exports.dart';
import '../../../../../utils/input_validator.dart';
import '../../../../common/widgets/form_input.dart';
import 'forgot_password_button.dart';

class SignInForm extends StatelessWidget {
  final Key formKey;
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final void Function()? onPasswordSubmitted;
  final void Function() onForgotPassword;

  const SignInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.emailFocusNode,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.onForgotPassword,
    this.onPasswordSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Column(
        children: [
          //$ Inputs
          FormInput(
            label: l10n.authEmail,
            hint: l10n.authEmailHint,
            type: FormInputType.email,
            controller: emailController,
            focusNode: emailFocusNode,
            nextFocusNode: passwordFocusNode,
            validator: InputValidators.validateEmail,
          ),
          VerticalSpacing(AppMetrics.spacing.md),
          FormInput(
            type: FormInputType.password,
            label: l10n.authPassword,
            hint: l10n.authPasswordHint,
            focusNode: passwordFocusNode,
            controller: passwordController,
            validator: InputValidators.validateLoginPassword,
            onFieldSubmitted: onPasswordSubmitted,
          ),
          //$ Forgot Password Button
          ForgotPasswordButton(onTap: onForgotPassword),
        ],
      ),
    );
  }
}
