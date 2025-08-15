//? Base needed imports
import '../../../../../base/screens/exports.dart';

//? Sub widgets needed imports
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
  Widget build(BuildContext context) =>
     SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: bloc.formKey,
            child: Column(
              children: [
              //$ Header
              const Header(),
              VerticalSpacing(AppMetrics.spacing.section),              
              //$ Inputs  
              FormInput(
                type: FormInputType.email,
                label: 'Email Address',
                hint: 'Enter your email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              VerticalSpacing(AppMetrics.spacing.sm),
              FormInput(
                type: FormInputType.password,
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              //$ Forgot Password Button
              ForgotPasswordButton(
                onTap: bloc.forgotPassword,
              ),
              VerticalSpacing(AppMetrics.spacing.sm),

              //$ Sign In Button
              LoadingButton(
                title: 'Sign In',
                onTap: bloc.signIn,
                isLoading: state is Loading,
                titleFontSize: FontSizes.title,
                height: AppMetrics.buttons.elevated.height,
              ),
              //$ Or Divider
              VerticalSpacing(AppMetrics.spacing.md),
              OrDivider(),
              //$ Create Account Button
              VerticalSpacing(AppMetrics.spacing.sm),
              OutlinedLoadingButton(
                title: 'Create Account',
                onTap: bloc.createAccount,
                titleFontSize: FontSizes.title,
                height: AppMetrics.buttons.elevated.height,
              ),
              VerticalSpacing(AppMetrics.spacing.sm),
            //$ Continue as Guest Button
              CustomTextButton(
                title: 'Continue as Guest',
                onTap: bloc.continueAsGuest,
              ),
              ],
            ).overallPadding(15),
          ),
        ).center();
      
  
}