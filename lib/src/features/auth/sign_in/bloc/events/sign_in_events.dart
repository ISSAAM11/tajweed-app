import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//- SIGN IN
final class SignIn extends SignInEvent {
  final String email;
  final String password;

  SignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

//- ANOTHER EVENTS
final class ForgotPassword extends SignInEvent {
  @override
  List<Object> get props => [];
}
