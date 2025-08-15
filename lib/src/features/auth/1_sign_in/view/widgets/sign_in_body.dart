//? Base needed imports
import '../../../../../base/screens/exports.dart';

//? Sub widgets needed imports
import '../../../../../utils/input_validator.dart' show InputValidators;
import '../../../../common/widgets/custom_text_button.dart';
import '../../vm/states/sign_in_states.dart';
import 'forgot_password_button.dart';
import 'header.dart';
import '../../../../common/widgets/form_input.dart';
import '../../../../common/widgets/or_devider.dart';


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
          onTap: bloc.forgotPassword,
        ),
        //$ Sign In Button
        LoadingButton(
          title: 'Sign In',
          onTap: bloc.signIn,
          isLoading: state is Loading,
          titleFontSize: FontSizes.title,
          height: AppMetrics.buttons.elevated.height,
          useGradient: true,
          gradient: AppColors.primaryGradient,
        ),
        //$ Or Divider
        VerticalSpacing(AppMetrics.spacing.lg),
        OrDivider(),
        //$ Create Account Button
        VerticalSpacing(AppMetrics.spacing.md),
        OutlinedLoadingButton(
          title: 'Create Account',
          onTap: bloc.createAccount,
          titleFontSize: FontSizes.title,
          height: AppMetrics.buttons.elevated.height,
          textColor: AppColors.primary,
          borderGradient: AppColors.primaryGradient,
        ),
        VerticalSpacing(AppMetrics.spacing.md),
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