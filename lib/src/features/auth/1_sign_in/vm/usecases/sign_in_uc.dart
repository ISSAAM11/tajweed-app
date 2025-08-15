part of '../bloc/sign_in_bloc.dart';

//- Sign In
extension on SignInBloc {
  Future<void> _signInWithEmailAndPassword(SignIn event, Emitter<SignInState> emit) async {
    if(formKey.isUnvalid)return;
    emit(Loading());
      final result=await _signInDataSource
        .signInWithEmailAndPassword(event.email, event.password);
      final user=result.fold(
        (exception) => _handleSignInFailure(exception, emit),
        (user) => _handleSignInSuccess(user, emit),
      );
    user;
  }
}
void _handleSignInSuccess(User user, Emitter<SignInState> emit) =>
    emit(Success(user));

void _handleSignInFailure(Exception exception, Emitter<SignInState> emit) =>
    emit(Error.from(exception));