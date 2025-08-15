
import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:tajweed_ai/src/utils/input_validator.dart';

import '../../../../../base/bloc/exports.dart';
import '../../../../../base/screens/exports.dart' show GlobalKey, FormState;
import '../../data/models/user.dart';
import '../../datasource/sign_in_datasource.dart';
import '../events/sign_in_events.dart';
import '../states/sign_in_states.dart';

//$ USE CASES
part '../usecases/sign_in_uc.dart'  ;
part '../usecases/forgot_password_uc.dart'  ;
part '../usecases/create_account_uc.dart'  ;
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
  Future<void> signIn() async => add(SignIn(emailController.text, passwordController.text));
  Future<void> forgotPassword() async => add(ForgotPassword());
  Future<void> createAccount() async => add(CreateAccount());
  Future<void> continueAsGuest() async => add(ContinueAsGuest());

    

  SignInBloc(this._signInDataSource) : super(Idle(), debugginEnabled: true) {
    on<SignIn>(_signInWithEmailAndPassword);
    on<ForgotPassword>(_forgotPassword);
    on<CreateAccount>(_createAccount);
    on<ContinueAsGuest>(_continueAsGuest);
  }

  //@ LIFECYCLE
  @override
  void onDispose() {
    inputControllers.disposeAll();
    super.onDispose();
  }
  
}
