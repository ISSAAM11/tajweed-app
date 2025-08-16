part of '../bloc/sign_in_bloc.dart';

//- Sign In
extension on SignInBloc {
  Future<void> _signInWithEmailAndPassword(
    SignInWithEmailAndPassword event,
    Emitter<SignInState> emit,
  ) async {
    if (formKey.isUnvalid) return;

    emit(Loading());
    return await _signInDataSource
        .signInWithEmailAndPassword(event.email, event.password)
        .then(
          (response) => response.fold(
            (exception) => _handleSignInFailure(exception, emit),
            (data) => _handleSignInSuccess(data, emit),
          ),
        );
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogle event,
    Emitter<SignInState> emit,
  ) async {
    //TODO: Implement sign in with google
  }

  Future<void> _signInWithFacebook(
    SignInWithFacebook event,
    Emitter<SignInState> emit,
  ) async {
    //TODO: Implement sign in with facebook
  }
}

void _handleSignInSuccess(SignInModel response, Emitter<SignInState> emit) {
  if (response.data != null) {
    emit(Success(response.message));
    return;
    //! Dispatch NavigateToHome goRouter ( globalContext.push)
    //TODO: globalContext.go(HomeScreen.path);
  }
  throw Exception(response.message);
}

void _handleSignInFailure(Exception exception, Emitter<SignInState> emit) =>
    emit(Error.from(exception));
