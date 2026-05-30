part of '../bloc/sign_up_bloc.dart';

extension on SignUpBloc {
  Future<void> _signUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<SignUpState> emit,
  ) async {
    emit(Idle());
    if (secondStepFormKey.isUnvalid || countryObs.isNull || birthDateObs.isNull)
      return;
    if (!acceptedTerms.value) {
      return emit(Error.from(Exception("Accept our Terms of use to continue")));
    }

    emit(Loading());
    return await _signUpDataSource
        .signUpWithEmailAndPassword(
          email: email.getText(),
          firstNmae: firstNmae.getText(),
          lasttNmae: lasttNmae.getText(),
          birthDate: birthDateObs.value.toDate,
          password: password.getText(),
          gender: genderObs.value,
          country: countryObs.value.countryCode,
        )
        .then(
          (response) => response.fold(
            (exception) => _handleSignUpFailure(exception, emit),
            (data) => _handleSignUpSuccess(
              data,
              emit,
              currentIndex,
              pageController,
              secondStepFormKey,
            ),
          ),
        );
  }

  Future<void> _resendPin(ResendPin event, Emitter<SignUpState> emit) async {
    return await _signUpDataSource
        .resendActivationCode(email: email.getText())
        .then(
          (response) => response.fold(
            (exception) => _handleResendFailure(exception, emit),
            (data) => _handleResendSuccess(
              "We’ve sent you a new verification code. Please check your email.",
              emit,
              pinController,
              pinFocusNode,
            ),
          ),
        );
  }

  Future<void> _activateAccount(
    ActivateAccount event,
    Emitter<SignUpState> emit,
  ) async {
    if (pinController.text.trim().isEmpty) return;
    emit(Loading());
    return await _signUpDataSource
        .activateAccount(email: event.email, code: event.code)
        .then(
          (response) => response.fold(
            (exception) => _handleActivateFailure(
              exception,
              emit,
              pinController,
              pinFocusNode,
            ),
            (data) async {
              await _saveTokensAndEmitSuccess(data, emit);
            },
          ),
        );
  }

  Future<void> _saveTokensAndEmitSuccess(
    ActivateAccountResponse data,
    Emitter<SignUpState> emit,
  ) async {
    await _signUpDataSource.saveTokens(
      accessToken: data.data?.access ?? '',
      refreshToken: data.data?.refresh ?? '',
    );
    emit(Success("Account activated"));
  }
}

void _handleSignUpFailure(Exception exception, Emitter<SignUpState> emit) =>
    emit(Error.from(exception));

void _handleSignUpSuccess(
  SignUpModelResponse data,
  Emitter<SignUpState> emit,
  Observable<int> currentIndex,
  PageController controller,
  GlobalKey<FormState> formkey,
) {
  if (data.info == "EMAIL_ALREADY_EXISTS") {
    return emit(Error.from(Exception("Email already in use")));
  }
  if (formkey.isUnvalid) return;
  currentIndex.value += 1;
  controller.animateToPage(
    currentIndex.value,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
  emit(Idle());
}

void _handleActivateFailure(
  Exception exception,
  Emitter<SignUpState> emit,
  TextEditingController pin,
  FocusNode focus,
) {
  pin.text = '';
  focus.unfocus();
  return emit(Error.from(exception));
}

void _handleResendFailure(Exception exception, Emitter<SignUpState> emit) =>
    emit(Error.from(exception));

void _handleResendSuccess(
  String message,
  Emitter<SignUpState> emit,
  TextEditingController pin,
  FocusNode focus,
) {
  pin.text = '';
  focus.unfocus();
  return emit(ResendPinSuccess(message));
}
