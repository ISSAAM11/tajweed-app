import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}
//- Sign In
final class SignInWithEmailAndPassword extends SignInEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class SignInWithGoogle extends SignInEvent {
  const SignInWithGoogle();
}

final class SignInWithFacebook extends SignInEvent {
  const SignInWithFacebook();
}

final class NavigateToSignUp extends SignInEvent {
  const NavigateToSignUp();
}

final class ContinueAsGuest extends SignInEvent {
  const ContinueAsGuest();
}

final class NavigateToForgotPassword extends SignInEvent {
  const NavigateToForgotPassword();
}

