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

//- Sign Up
final class SignUpWithEmailAndPassword extends SignUpEvent {
  const SignUpWithEmailAndPassword();
}
