//? Base needed imports
import '../../../../../base/screens/exports.dart';
import '../../../2_sign_up/router/sign_up_route.dart';
import '../../vm/states/sign_in_states.dart';


//? Sub widgets needed imports
import 'dont_have_an_account.dart';
import 'forgot_password_button.dart';
import 'social_login_buttons.dart';
import '../../../../common/widgets/app_logo.dart';
import '../../../../common/widgets/form_input.dart';
import '../../../../common/widgets/or_devider.dart';
import '../../../../common/widgets/custom_text_button.dart';

//? Utils needed imports
import '../../../../../utils/input_validator.dart' show InputValidators;

//? Bloc needed imports
import '../../vm/bloc/sign_in_bloc.dart';

class SignInBody extends SubWidget<SignInBloc> {
  final SignInState state;
  const SignInBody(this.state, {super.key});
  
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Form(
      key: bloc.formKey,
      child: Column(
        children: [
        //$ Header
        const AppLogo(),
        VerticalSpacing(AppMetrics.spacing.sm),
        //$ App Info
        Text(
          'Tajweed AI',
          style: AppStyles.headline1.bold().primary(),
        ),
        VerticalSpacing(AppMetrics.spacing.xs),
        Text(
          'Learn Quran with AI',
          style: AppStyles.subtitle.medium().greyRegular(),
        ),
        VerticalSpacing(AppMetrics.spacing.xl),
        //$ Inputs  
        FormInput(
          type: FormInputType.email,
          controller: bloc.emailController,
          validator: InputValidators.validateEmail,
          label: 'Email Address',
          hint: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined),
          enableRealTimeValidation: true,
        ),
        VerticalSpacing(AppMetrics.spacing.md),
        FormInput(
          type: FormInputType.password,
          controller: bloc.passwordController,
          validator: InputValidators.validateLoginPassword,
          label: 'Password',
          hint: 'Enter your password',
          prefixIcon: const Icon(Icons.lock_outline),
          enableRealTimeValidation: true,
        ),
        //$ Forgot Password Button
        ForgotPasswordButton(
          onTap: (){
            // TODO: Navigate to forgot password
          },
        ),
        //$ Sign In Button
        LoadingButton(
          title: 'Sign In',
          onTap: bloc.signInWithEmailAndPassword,
          isLoading: state is Loading,
          titleFontSize: FontSizes.title,
          height: AppMetrics.buttons.elevated.height,
          useGradient: true,
          gradient: AppColors.primaryGradient,
        ),
        //$ Or Divider
        VerticalSpacing(AppMetrics.spacing.xs),
        OrDivider(),
        VerticalSpacing(AppMetrics.spacing.sm),
        //$ Social Login Buttons
        SocialLoginButtons(
          onGoogleTap: bloc.signInWithGoogle,
          onFacebookTap: bloc.signInWithFacebook,
        ),
        VerticalSpacing(AppMetrics.spacing.sm),
      //$ Don't have an account? Create one
       DontHaveAccount(
        onTap: ()=>globalContext.push(signUpRoute.path),
       ),
        //$ Continue as Guest Button
        CustomTextButton(
          title: 'Continue as Guest',
          onTap: bloc.continueAsGuest,
        ),
        ],
      ).overallPadding(15),
    ),
  ).center().gradientBackground();
}