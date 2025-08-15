import 'package:equatable/equatable.dart';

import '../../data/models/user.dart';

sealed class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Idle extends SignInState {}

final class Loading extends SignInState {}

final class Success extends SignInState {
  final User userAccount;

  Success(this.userAccount);

  @override
  List<Object> get props => [userAccount];
}

final class Error extends SignInState implements Exception {
  final String message;

  Error._(this.message);

  factory Error.from(Exception exception) => Error._(exception.toString());

  @override
  List<Object> get props => [message];
}
