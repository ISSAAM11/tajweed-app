import 'package:equatable/equatable.dart';

sealed class ShiftHandoverEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//- GET SHIFT REPORT
final class GetShiftReport extends ShiftHandoverEvent {
  final String caregiverId;

  GetShiftReport(this.caregiverId);

  @override
  List<Object> get props => [caregiverId];
}

//- ANOTHER EVENTS
final class GetAnotherEvent extends ShiftHandoverEvent {
  @override
  List<Object> get props => [];
}
