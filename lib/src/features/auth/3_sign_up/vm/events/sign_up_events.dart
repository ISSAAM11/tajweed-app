import 'package:equatable/equatable.dart';

import '../../../../../base/screens/exports.dart' show Observable;

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class NextStep extends SignUpEvent {
  final Observable<int> current;

  const NextStep(this.current);

  @override
  List<Object> get props => [current];
}

final class PreviousStep extends SignUpEvent {
  final Observable<int> current;

  const PreviousStep(this.current);

  @override
  List<Object> get props => [current];
}

final class ResendPin extends SignUpEvent {
  final String email;

  const ResendPin(this.email);

  @override
  List<Object> get props => [email];
}

final class ActivateAccount extends SignUpEvent {
  final String email;
  final String code;

  const ActivateAccount({required this.email, required this.code});
  @override
  List<Object> get props => [email, code];
}

//- Sign Up
final class SignUpWithEmailAndPassword extends SignUpEvent {
  const SignUpWithEmailAndPassword();
}
