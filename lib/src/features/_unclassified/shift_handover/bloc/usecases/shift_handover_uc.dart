part of '../shift_handover_bloc.dart';

//- GET SHIFT REPORT
extension on ShiftHandoverBloc {
  void _loadShiftReport(GetShiftReport event, Emitter<ShiftHandoverState> emit) async {
    emit(Loading());

    await shiftHandoverDataSource
        .getShiftReport('current-user-id')
        .then(
          (result) => result.fold(
            (exception) => _handleShiftHandoverFailure(exception, emit),
            (shiftReport) => _handleLoadShiftReport(shiftReport, emit),
          ),
        );
  }

  void _handleShiftHandoverFailure(Exception exception, Emitter<ShiftHandoverState> emit) =>
      emit(Error.from(exception));

  void _handleLoadShiftReport(ShiftReportDO shiftReport, Emitter<ShiftHandoverState> emit) =>
      emit(shiftReport.notes.isEmpty ? Empty() : Success(shiftReport: shiftReport));
}
