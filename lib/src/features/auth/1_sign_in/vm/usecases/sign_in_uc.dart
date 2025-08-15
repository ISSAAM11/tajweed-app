part of '../bloc/sign_in_bloc.dart';

//- Sign In
extension on SignInBloc {
  void _signIn(SignIn event, Emitter<SignInState> emit) async {
    emit(Loading());

    await signInDataSource
        .signIn(event.email, event.password)
        .then(
          (result) => result.fold(
            (exception) => _handleSignInFailure(exception, emit),
            (user) => _handleLoadUser(user, emit),
          ),
        );
  }

  void _handleSignInFailure(Exception exception, Emitter<SignInState> emit) =>
      emit(Error.from(exception));
  
  void _handleLoadUser(User user, Emitter<SignInState> emit) =>
      emit(Success(user));

}
