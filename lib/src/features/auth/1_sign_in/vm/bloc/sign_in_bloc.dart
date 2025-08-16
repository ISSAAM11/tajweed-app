import 'package:cg_core_defs/cg_core_defs.dart';

import '../../../../../base/screens/exports.dart' show GlobalKey, FormState;
import 'package:tajweed_ai/src/utils/input_validator.dart';

import '../../../../../base/bloc/exports.dart';
import '../../data/models/sign_in_model.dart';
import '../../datasource/sign_in_datasource.dart';
import '../events/sign_in_events.dart';
import '../states/sign_in_states.dart';

//$ USE CASES
part '../usecases/sign_in_uc.dart'  ;
part '../usecases/continue_as_guest_uc.dart'  ;

class SignInBloc extends BaseBloc<SignInEvent, SignInState> {
  //! Data Sources
  final SignInDataSource _signInDataSource;

  //! Keys
  final formKey = GlobalKey<FormState>();

  //! Input Controllers
  final inputControllers=InputControl.generate(2);
  late final  emailController=inputControllers[0].controller  ;
  late final  passwordController=inputControllers[1].controller  ;

  //! Event Callers
  Future<void> signInWithEmailAndPassword() async => 
    add(SignInWithEmailAndPassword(emailController.text, passwordController.text));
  Future<void> signInWithGoogle() async => add(SignInWithGoogle());
  Future<void> signInWithFacebook() async => add(SignInWithFacebook());
  Future<void> continueAsGuest() async => add(ContinueAsGuest());



  SignInBloc(this._signInDataSource) : super(Idle(), debugginEnabled: true) {
    on<SignInWithEmailAndPassword>(_signInWithEmailAndPassword);
    on<SignInWithGoogle>(_signInWithGoogle);
    on<SignInWithFacebook>(_signInWithFacebook);
    on<ContinueAsGuest>(_continueAsGuest);
  }

  //@ LIFECYCLE
  @override
  void onDispose() {
    inputControllers.clearAllTECs();
    inputControllers.unfocusAllFocusNodes();
    inputControllers.disposeAll();
    super.onDispose();
  }
  
}
