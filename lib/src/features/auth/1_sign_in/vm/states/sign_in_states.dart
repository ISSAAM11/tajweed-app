import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Idle extends SignInState {}

final class Loading extends SignInState {}

final class Success extends SignInState {
  final String message;

  Success(this.message);

  @override
  List<Object> get props => [message];
}

final class Error extends SignInState implements Exception {
  final String message;

  Error._(this.message);
  factory Error.from(Exception exception) => Error._(exception.toString().replaceAll('Exception: ', ''));

  @override
  List<Object> get props => [message];
  
}
