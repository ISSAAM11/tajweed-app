// ignore_for_file: unused_element

part of '../shift_handover_bloc.dart';

//- ANOTHER EVENTS
extension on ShiftHandoverBloc {
  void _anotherEvent(GetShiftReport event, Emitter<ShiftHandoverState> emit) async {
    emit(Loading());
  }

  void _handleAnotherEventFailure(Exception exception, Emitter<ShiftHandoverState> emit) {
    emit(Error.from(exception));
  }

  void _handleAnotherEventSuccess(ShiftReportDO? shiftReport, Emitter<ShiftHandoverState> emit) =>
      (shiftReport == null) ? emit(Empty()) : emit(Success(shiftReport: shiftReport));
}
