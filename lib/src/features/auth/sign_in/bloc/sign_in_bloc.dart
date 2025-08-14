import '../../../../base/bloc/exports.dart';
import '../data/datasource/sign_in_datasource.dart';
import 'events/sign_in_events.dart';
import 'states/sign_in_states.dart';


//$ USE CASES
// part 'usecases/another_uc.dart';
// part 'usecases/shift_handover_uc.dart';

class SignInBloc extends BaseBloc<SignInEvent, SignInState> {
  final SignInDataSource signInDataSource;

  SignInBloc(this.signInDataSource) : super(SignInInitial(), debugginEnabled: true) {
    on<SignIn>(_onSignIn);
  }

  //& LIFECYCLE
  @override
  void onReady() {
    // add(GetShiftReport('current-user-id'));
    super.onReady();
  }

  //+ SHARED METHODS
  void accessHome() {
    // Debugger.white('$ShiftHandoverBloc is accessing home');
  }
  //TODO: implement _onSignIn
  void _onSignIn(SignIn event, Emitter<SignInState> emit) {
    emit(Loading());
  }
}
