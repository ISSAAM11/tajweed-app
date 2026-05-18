//? Base needed imports
import '../../../../../base/screens/exports.dart';

//? Widgets Imports
import '/src/features/auth/2_sign_in/view/widgets/sign_in_form.dart';
import '../../../common/auth_body.dart';

//? Utils needed imports
import '../../../3_sign_up/router/sign_up_route.dart';

//? Bloc needed imports
import '../../vm/bloc/sign_in_bloc.dart';
import '../../vm/states/sign_in_states.dart';

class SignInBody extends SubWidget<SignInBloc> {
  final SignInState state;
  const SignInBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) => AuthBody(
    buttonTitle: "Sign In",
    onButtonTap: bloc.signInWithEmailAndPassword,
    isLoading: state is Loading,
    showOrDivider: true,
    showSocialLogin: true,
    showGuestOption: true,
    accountQuestionFirstText: "Don't have an Account? ",
    accountQuestionSecondText: "create one",
    onAccountQuestionTap: () => globalContext.go(signUpRoute.path),
    guestQuestionFirstText: "Or continue as ",
    guestQuestionSecondText: "Guest",
    onGuestQuestionTap: bloc.continueAsGuest,
    onGoogleTap: bloc.signInWithGoogle,
    onFacebookTap: bloc.signInWithFacebook,
    onAppleTap: bloc.signInWithApple,
    child: SignInForm(
      formKey: bloc.formKey,
      emailController: bloc.email.controller,
      emailFocusNode: bloc.email.node,
      passwordController: bloc.password.controller,
      passwordFocusNode: bloc.password.node,
      onForgotPassword: () {
        //TODO: Go to forgot password
      },
    ),
  );
}
