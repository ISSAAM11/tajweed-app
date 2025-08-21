import 'package:tajweed_ai/src/features/auth/export.dart';

import '../../../../../base/screens/exports.dart';

import '../../../common/auth_body.dart';
import '../../vm/bloc/sign_up_bloc.dart';
import '../../vm/states/sign_up_states.dart';
import 'sign_up_form.dart';

class SignupBody extends SubWidget<SignUpBloc> {
  final SignUpState state;
  const SignupBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) => AuthBody(
    buttonTitle: "Sign Up",
    isLoading: state is Loading,
    showOrDivider: false,
    showSocialLogin: true,
    showGuestOption: true,
    accountQuestionFirstText: "Already have an Account? ",
    accountQuestionSecondText: "sign in",
    onAccountQuestionTap: () => globalContext.go(signInRoute.path),
    guestQuestionFirstText: "Or continue as ",
    guestQuestionSecondText: "Guest",
    child: SignUpForm(
      currentStep: bloc.currentIndex,
      firstStepFormKey: bloc.firstStepFormKey,
      secondStepFormKey: bloc.secondStepFormKey,
      firstName: bloc.firstNmae,
      lastName: bloc.lasttNmae,
      email: bloc.email,
      password: bloc.password,
      confirmPassword: bloc.confirmPassword,
      acceptedTerms: bloc.acceptedTerms,
      pageController: bloc.pageController,
      nextAction: bloc.next,
      previousActions: bloc.previous,
      birthDate: bloc.birthDateObs,
      country: bloc.countryObs,
      selectedGenderObs: bloc.genderObs,
      isLoading: state is Loading,
      pinController: bloc.pinController,
      pinFocusNode: bloc.pinFocusNode,
      resnedPin: bloc.resendPin,
    ),
  );
}
