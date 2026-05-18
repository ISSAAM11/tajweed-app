import 'package:cg_core_defs/cg_core_defs.dart' show InputControl;

import '../../../../../base/screens/exports.dart'
    show FormState, GlobalKey, InputControlsListDisposer;
import 'package:tajweed_ai/src/utils/input_validator.dart';

import '../../../../../base/bloc/exports.dart';
import '../../data/models/sign_in_model.dart';
import '../../datasource/sign_in_datasource.dart';
import '../events/sign_in_events.dart';
import '../states/sign_in_states.dart';

//$ USE CASES
part '../usecases/sign_in_uc.dart';
part '../usecases/continue_as_guest_uc.dart';

class SignInBloc extends BaseBloc<SignInEvent, SignInState> {
  //! Data Sources
  final SignInDataSource _signInDataSource;

  //! Keys
  final formKey = GlobalKey<FormState>();

  //! Input Controllers
  late final List<InputControl> inputControllers;
  late final InputControl email;
  late final InputControl password;

  //! Event Callers
  Future<void> signInWithEmailAndPassword() async => add(
    SignInWithEmailAndPassword(email.controller.text, password.controller.text),
  );
  Future<void> signInWithGoogle() async => add(SignInWithGoogle());
  Future<void> signInWithFacebook() async => add(SignInWithFacebook());
  Future<void> signInWithApple() async => add(SignInWithApple());
  Future<void> continueAsGuest() async => add(ContinueAsGuest());

  SignInBloc(this._signInDataSource) : super(Idle(), debugginEnabled: true) {
    on<SignInWithEmailAndPassword>(_signInWithEmailAndPassword);
    on<SignInWithGoogle>(_signInWithGoogle);
    on<SignInWithFacebook>(_signInWithFacebook);
    on<SignInWithApple>(_signInWithApple);
    on<ContinueAsGuest>(_continueAsGuest);
  }

  //@ LIFECYCLE
  @override
  void onInit() {
    inputControllers = InputControl.generate(2);
    email = inputControllers[0];
    password = inputControllers[1];
    super.onInit();
  }

  @override
  void onDispose() {
    inputControllers.disposeAll();
    super.onDispose();
  }
}
