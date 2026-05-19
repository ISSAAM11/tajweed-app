import 'package:tajweed_ai/l10n/app_localizations.dart';
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AuthBody(
      buttonTitle: l10n.authSignUp,
      isLoading: state is Loading,
      showOrDivider: false,
      showSocialLogin: true,
      showGuestOption: true,
      accountQuestionFirstText: l10n.authHaveAccountQuestion,
      accountQuestionSecondText: l10n.authSignInLink,
      onAccountQuestionTap: () => globalContext.go(signInRoute.path),
      guestQuestionFirstText: l10n.authOrContinueAs,
      guestQuestionSecondText: l10n.authGuest,
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
        onPinSubmitted: bloc.pinSubmit,
        resnedPin: bloc.resendPin,
      ),
    );
  }
}
