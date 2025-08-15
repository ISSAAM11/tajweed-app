import 'package:equatable/equatable.dart';

import '../../data/models/user.dart';

sealed class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Loading extends SignInState {}

final class Empty extends SignInState {
  @override
  List<Object> get props => [];
}

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
