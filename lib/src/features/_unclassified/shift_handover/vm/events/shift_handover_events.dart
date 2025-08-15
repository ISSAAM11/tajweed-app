import 'package:equatable/equatable.dart';

sealed class ShiftHandoverEvent extends Equatable {
  const ShiftHandoverEvent();

  @override
  List<Object> get props => [];
}

//- GET SHIFT REPORT
final class GetShiftReport extends ShiftHandoverEvent {
  final String caregiverId;

  const GetShiftReport(this.caregiverId);

  @override
  List<Object> get props => [caregiverId];
}

//- ACCESS HOME
final class AccessHome extends ShiftHandoverEvent {
  const AccessHome();
}
