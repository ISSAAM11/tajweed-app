import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

//- Sign In
final class SignIn extends SignInEvent {
  final String email;
  final String password;

  const SignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

//- Forgot Password
final class ForgotPassword extends SignInEvent {
  const ForgotPassword();
}
