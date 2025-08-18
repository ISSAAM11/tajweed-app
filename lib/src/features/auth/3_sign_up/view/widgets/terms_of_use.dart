part of 'sign_up_form.dart';

class _TermsOfUse extends StatelessWidget {
  const _TermsOfUse({super.key, required this.isChecked, this.onTermsPressed});

  final Observable<bool> isChecked;
  final VoidCallback? onTermsPressed;
  void showTermsOfUseDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // user must choose
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.buttons.radius),
          ),
          title: Text(
            "Terms of Use",
            style: AppStyles.title.semiBold().copyWith(color: AppColors.black),
          ),
          content: SizedBox(
            height: 250, // make it scrollable
            child: SingleChildScrollView(
              child: Text("""
By using this app, you agree to the following Terms of Use:

1. You will use the app responsibly.
2. You will not misuse or exploit its features.
3. The app may collect data as per our Privacy Policy.
4. We may update the Terms at any time.

Please read carefully before continuing.
              """, style: AppStyles.subtitle.copyWith(color: AppColors.black)),
            ),
          ),
          actions: [
            LoadingButton(
              title: 'OK',
              onTap: () {
                Navigator.of(context).pop(true); // user accepted
              },
              titleFontSize: FontSizes.title,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Row(
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
            text: "I agree to the ",
            style: AppStyles.indication.semiBold().greyDark(),
            children: [
              TextSpan(
                text: "Terms of Use",
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
