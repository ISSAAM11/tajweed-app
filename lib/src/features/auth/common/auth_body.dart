//? Base needed imports
import '../../../base/screens/exports.dart';
import '../../common/widgets/app_logo.dart';
import '../../common/widgets/or_devider.dart';

//? Sub widgets needed imports
import 'did_user_have_an_account.dart';
import 'social_login_buttons.dart';

//? Utils needed imports

class AuthBody extends StatelessWidget {
  final Widget child;
  final String buttonTitle;
  final VoidCallback? onButtonTap;
  final bool isLoading;
  final bool showOrDivider;
  final bool showSocialLogin;
  final bool showGuestOption;
  final String? accountQuestionFirstText;
  final String? accountQuestionSecondText;
  final VoidCallback? onAccountQuestionTap;
  final String? guestQuestionFirstText;
  final String? guestQuestionSecondText;
  final VoidCallback? onGuestQuestionTap;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;
  final VoidCallback? onAppleTap;

  const AuthBody({
    super.key,
    required this.child,
    required this.buttonTitle,
    this.onButtonTap,
    this.isLoading = false,
    this.showOrDivider = true,
    this.showSocialLogin = true,
    this.showGuestOption = true,
    this.accountQuestionFirstText,
    this.accountQuestionSecondText,
    this.onAccountQuestionTap,
    this.guestQuestionFirstText,
    this.guestQuestionSecondText,
    this.onGuestQuestionTap,
    this.onGoogleTap,
    this.onFacebookTap,
    this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.symmetric(
      horizontal: AppMetrics.scaffold.horizontalBodyPadding,
      vertical: AppMetrics.scaffold.topBodyPadding,
    ),
    child: Column(
      children: [
        //$ Header
        const AppLogo(),
        //$ App Info
        Text('Tajweed AI', style: AppStyles.headline1.bold().primary()),
        VerticalSpacing(AppMetrics.spacing.xs),
        Text(
          "Master Qur'an Recitation with AI Guidance.",
          style: AppStyles.subtitle.medium().greyRegular(),
        ),
        VerticalSpacing(AppMetrics.spacing.xl),
        //$ Form
        child,
        VerticalSpacing(AppMetrics.spacing.md),
        //$ Main Button
        if (onButtonTap != null)
          LoadingButton(
            title: buttonTitle,
            onTap: onButtonTap!,
            isLoading: isLoading,
            titleFontSize: FontSizes.title,
            height: AppMetrics.buttons.elevated.height,
            useGradient: true,
          ),
        //$ Or Divider
        if (showOrDivider) ...[
          VerticalSpacing(AppMetrics.spacing.xs),
          OrDivider(),
          VerticalSpacing(AppMetrics.spacing.sm),
        ],
        //$ Social Login Buttons
        if (showSocialLogin &&
            (onGoogleTap != null ||
                onFacebookTap != null ||
                onAppleTap != null)) ...[
          SocialLoginButtons(
            onGoogleTap: onGoogleTap ?? () {},
            onFacebookTap: onFacebookTap ?? () {},
            onAppleTap: onAppleTap ?? () {},
          ),
          VerticalSpacing(AppMetrics.spacing.sm),
        ],
        //$ Account Question
        if (accountQuestionFirstText != null &&
            accountQuestionSecondText != null &&
            onAccountQuestionTap != null)
          DidUserHaveAnAccount(
            firstText: accountQuestionFirstText!,
            secondText: accountQuestionSecondText!,
            onTap: onAccountQuestionTap!,
          ),
        //$ Guest Option
        if (showGuestOption &&
            guestQuestionFirstText != null &&
            guestQuestionSecondText != null &&
            onGuestQuestionTap != null)
          DidUserHaveAnAccount(
            firstText: guestQuestionFirstText!,
            secondText: guestQuestionSecondText!,
            onTap: onGuestQuestionTap!,
          ),
      ],
    ).overallPadding(15),
  ).center().gradientBackground();
}
