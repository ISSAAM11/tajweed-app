import 'package:equatable/equatable.dart';

import '../../data/models/shift_report_do.dart';

sealed class ShiftHandoverState extends Equatable {
  @override
  List<Object> get props => [];
}

final class Loading extends ShiftHandoverState {}

final class Empty extends ShiftHandoverState {
  @override
  List<Object> get props => [];
}

final class Success extends ShiftHandoverState {
  final ShiftReportDO shiftReport;

  Success({required this.shiftReport});

  @override
  List<Object> get props => [shiftReport];
}

final class Error extends ShiftHandoverState implements Exception {
  final String message;

  Error._(this.message);

  factory Error.from(Exception exception) => Error._(exception.toString());

  @override
  List<Object> get props => [message];
}
