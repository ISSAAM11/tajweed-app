part of 'sign_up_form.dart';

class _Step1 extends StatelessWidget {
  final Key formKey;
  final InputControl email;
  final InputControl password;
  final InputControl confirmPassword;
  const _Step1({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      children: [
        VerticalSpacing(AppMetrics.spacing.md),
        FormInput(
          label: 'Email',
          type: FormInputType.email,
          controller: email.controller,
          focusNode: email.node,
          nextFocusNode: password.node,
          validator: InputValidators.validateEmail,
        ),
        VerticalSpacing(AppMetrics.spacing.md),
        FormInput(
          type: FormInputType.password,
          label: 'Password',
          controller: password.controller,
          focusNode: password.node,
          nextFocusNode: confirmPassword.node,
          validator: InputValidators.validatePassword,
        ),
        VerticalSpacing(AppMetrics.spacing.md),
        FormInput(
          type: FormInputType.password,
          label: 'Confirm Password',
          controller: confirmPassword.controller,
          focusNode: confirmPassword.node,
          validator: (value) => InputValidators.validateConfirmPassword(
            value,
            password.controller.text,
          ),
        ),
      ],
    ),
  );
}
