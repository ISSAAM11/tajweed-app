part of 'sign_up_form.dart';

class _Step3 extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;
  final void Function(String) onCompleted;
  final void Function() resend;

  const _Step3({
    super.key,
    required this.pinController,
    required this.pinFocusNode,
    required this.onCompleted,
    required this.resend,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: AppStyles.headline3.semiBold().copyWith(
        color: scheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        VerticalSpacing(AppMetrics.scaffold.horizontalBodyPadding),
        Text(
          l10n.authCheckInbox,
          style: AppStyles.headline3.bold().copyWith(color: AppColors.tertiary),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.authVerificationMessage,
          style: AppStyles.title.semiBold().copyWith(color: scheme.onSurface),
          textAlign: TextAlign.center,
        ),
        VerticalSpacing(AppMetrics.scaffold.horizontalBodyPadding),
        Pinput(
          autofillHints: const [AutofillHints.oneTimeCode],
          enableSuggestions: false,
          autofocus: true,
          length: 4,
          controller: pinController,
          focusNode: pinFocusNode,
          pinAnimationType: PinAnimationType.fade,
          onCompleted: onCompleted,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.accent),
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.success),
            ),
          ),
          errorPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.error),
            ),
          ),
          cursor: Container(
            width: 10,
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        VerticalSpacing(AppMetrics.scaffold.horizontalBodyPadding / 2),
        Row(
          children: [
            const Spacer(),
            CustomTextButton(
              title: l10n.authResendCode,
              onTap: resend,
              textColor: AppColors.primary,
            ),
          ],
        ).symmetricPadding(vertical: 8),
      ],
    );
  }
}
