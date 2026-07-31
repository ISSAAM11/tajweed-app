//? Base needed imports
import 'package:tajweed_ai/l10n/app_localizations.dart';

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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AuthBody(
      buttonTitle: l10n.authSignIn,
      onButtonTap: bloc.signInWithEmailAndPassword,
      isLoading: state is Loading,
      showOrDivider: true,
      showSocialLogin: true,
      showGuestOption: true,
      accountQuestionFirstText: l10n.authNoAccountQuestion,
      accountQuestionSecondText: l10n.authCreateOne,
      onAccountQuestionTap: () => globalContext.go(signUpRoute.path),
      guestQuestionFirstText: l10n.authOrContinueAs,
      guestQuestionSecondText: l10n.authGuest,
      onGuestQuestionTap: () => globalContext.go('/home'),
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
}
