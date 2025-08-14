import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

final class Loading extends SignInState {}

final class Success extends SignInState {
  Success();

  @override
  List<Object> get props => [];
}

final class Error extends SignInState implements Exception {
  final String message;

  Error._(this.message);

  factory Error.from(Exception exception) => Error._(exception.toString());

  @override
  List<Object> get props => [message];
}
