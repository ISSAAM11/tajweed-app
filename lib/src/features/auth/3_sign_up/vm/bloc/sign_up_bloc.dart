import 'package:cg_core_defs/cg_core_defs.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tajweed_ai/src/utils/input_validator.dart';

import '../../../../../base/bloc/exports.dart';
import '../../../../../base/screens/exports.dart' show GlobalKey, FormState;
import '../../datasource/sign_up_datasource.dart';
import '../events/sign_up_events.dart';
import '../states/sign_up_states.dart';

//$ USE CASES
// part '../usecases/sign_up_uc.dart'  ;
// part '../usecases/sign_up_navigation_uc.dart'  ;
// part '../usecases/continue_as_guest_uc.dart'  ;

class SignUpBloc extends BaseBloc<SignUpEvent, SignUpState> {
  //! Data Sources
  final SignUpDataSource _signUpDataSource;

  //! Keys
  final formKey = GlobalKey<FormState>();

  //! Input Controllers
  final inputControllers = InputControl.generate(2);
  late final emailController = inputControllers[0].controller;
  late final passwordController = inputControllers[1].controller;

  //! Event Callers
  // Future<void> signUpWithEmailAndPassword() async =>
  //   add(SignUpWithEmailAndPassword(emailController.text, passwordController.text));
  // Future<void> signUpWithGoogle() async => add(SignUpWithGoogle());
  // Future<void> signUpWithFacebook() async => add(SignUpWithFacebook());
  // Future<void> continueAsGuest() async => add(ContinueAsGuest());
  // Future<void> navigateToSignIn() async => add(NavigateToSignIn());
  // Future<void> navigateToForgotPassword() async => add(NavigateToForgotPassword());

  SignUpBloc(this._signUpDataSource) : super(Idle(), debugginEnabled: true) {
    // on<SignUpWithEmailAndPassword>(_signUpWithEmailAndPassword);
    // on<SignUpWithGoogle>(_signUpWithGoogle);
    // on<SignUpWithFacebook>(_signUpWithFacebook);
    // on<ContinueAsGuest>(_continueAsGuest);
    // on<NavigateToForgotPassword>(_navigateToForgotPassword);
    // on<NavigateToSignIn>(_navigateToSignIn);
  }

  //@ LIFECYCLE
  @override
  void onDispose() {
    inputControllers.disposeAll();
    super.onDispose();
  }
}
