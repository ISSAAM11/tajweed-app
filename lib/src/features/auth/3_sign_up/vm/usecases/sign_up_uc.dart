part of '../bloc/sign_up_bloc.dart';

extension on SignUpBloc {
  Future<void> _signUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<SignUpState> emit,
  ) async {
    if (secondStepFormKey.isUnvalid || countryObs.isNull || birthDateObs.isNull)
      return;
    if (!acceptedTerms.value) {
      emit(Error.from(Exception("Accept our Terms of use to continue")));
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
            (exception) => emit(Error.from(exception)),
            (data) => emit(Success("Yess")),
          ),
        );
  }
}
