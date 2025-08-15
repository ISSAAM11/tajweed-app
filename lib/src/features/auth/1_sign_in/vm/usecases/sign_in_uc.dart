part of '../bloc/sign_in_bloc.dart';

//- Sign In
extension on SignInBloc {
  Future<void> _signInWithEmailAndPassword(SignIn event, Emitter<SignInState> emit) async {
    emit(Loading());
    try{
      final result=await signInDataSource
        .signInWithEmailAndPassword(event.email, event.password);

        result.fold(
          (exception) => _handleSignInFailure(exception, emit),
          (user) => _handleSignInSuccess(user, emit),
        );
    }catch(e){  
      emit(Error.from(e as Exception));

    }finally{
      emit(Idle());
    }
    
  }

}
void _handleSignInSuccess(User user, Emitter<SignInState> emit) =>
    emit(Success(user));

void _handleSignInFailure(Exception exception, Emitter<SignInState> emit) =>
    emit(Error.from(exception));