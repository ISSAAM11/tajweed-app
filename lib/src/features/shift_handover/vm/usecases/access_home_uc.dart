part of '../bloc/shift_handover_bloc.dart';

//- ACCESS HOME
extension AccessHomeUC on ShiftHandoverBloc {
  //? ACCESS HOME
  static const _accessHomeEvent = AccessHome();

  void accessHome() => add(_accessHomeEvent);

  void _accessHome(AccessHome event, Emitter<ShiftHandoverState> emit) async {
    Debugger.white('$ShiftHandoverBloc is accessing home');

    accessingHomeObs.enable();

    await Future.delayed(const Duration(seconds: 1));

    accessingHomeObs.disable();
  }
}
