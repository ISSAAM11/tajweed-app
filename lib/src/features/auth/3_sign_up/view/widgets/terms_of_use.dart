part of 'sign_up_form.dart';

class _TermsOfUse extends StatelessWidget {
  const _TermsOfUse({super.key, required this.isChecked, this.onTermsPressed});

  final Observable<bool> isChecked;
  final VoidCallback? onTermsPressed;

  void showTermsOfUseDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.buttons.radius),
          ),
          title: Text(
            l10n.authTermsOfUseTitle,
            style: AppStyles.title.semiBold().copyWith(color: AppColors.black),
          ),
          content: SizedBox(
            height: 250,
            child: SingleChildScrollView(
              child: Text(
                l10n.authTermsOfUseBody,
                style: AppStyles.subtitle.copyWith(color: AppColors.black),
              ),
            ),
          ),
          actions: [
            LoadingButton(
              title: l10n.snackbarOk,
              onTap: () {
                Navigator.of(context).pop(true);
              },
              titleFontSize: FontSizes.title,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Observer(
          observes: isChecked,
          builder: (BuildContext context, value) => Checkbox(
            fillColor: WidgetStateProperty.all(AppColors.secondary),
            checkColor: AppColors.primaryDark,
            value: value,
            onChanged: (_) {
              isChecked.toggle();
            },
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: l10n.authIAgreeToThe,
              style: AppStyles.indication.semiBold().greyDark(),
              children: [
                TextSpan(
                  text: l10n.authTermsOfUseTitle,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => showTermsOfUseDialog(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
