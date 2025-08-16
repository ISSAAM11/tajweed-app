import 'package:equatable/equatable.dart';

sealed class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Idle extends SignUpState {}

final class Loading extends SignUpState {}

final class Success extends SignUpState {
  final String message;

  Success(this.message);

  @override
  List<Object> get props => [message];
}

final class Error extends SignUpState implements Exception {
  final String message;

  Error._(this.message);
  factory Error.from(Exception exception) =>
      Error._(exception.toString().replaceAll('Exception: ', ''));

  @override
  List<Object> get props => [message];
}
