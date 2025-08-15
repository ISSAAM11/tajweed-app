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


final class CreateAccount extends SignInEvent {
  const CreateAccount();
}

final class ContinueAsGuest extends SignInEvent {
  const ContinueAsGuest();
}

//! Future Implementations to support other sign in methods
// final class SignInWithGoogle extends SignInEvent {
//   const SignInWithGoogle();
// }

// final class SignInWithApple extends SignInEvent {
//   const SignInWithApple();
// }

// final class SignInWithFacebook extends SignInEvent {
//   const SignInWithFacebook();
// }
