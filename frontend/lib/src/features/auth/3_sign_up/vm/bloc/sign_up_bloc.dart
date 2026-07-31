import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:country_picker/country_picker.dart';
import 'package:tajweed_ai/src/base/extensions/date_time_ext.dart';
import 'package:tajweed_ai/src/utils/input_validator.dart';
import '../../../../../base/bloc/exports.dart';
import '../../../../../base/screens/exports.dart'
    show GlobalKey, FormState, PageController, Curves;
import '../../data/models/activate_account_response.dart';
import '../../data/models/sign_up_model.dart';

//$ DATA SOURCES
import '../../datasource/sign_up_datasource.dart';

//$ EVENTS
import '../events/sign_up_events.dart';
import '../states/sign_up_states.dart';

//$ USE CASES
part '../usecases/sign_up_uc.dart';
part '../usecases/steps_uc.dart';

base class SignUpBloc extends BaseBloc<SignUpEvent, SignUpState> {
  //! Data Sources
  final SignUpDataSource _signUpDataSource;

  //! Keys
  final firstStepFormKey = GlobalKey<FormState>();
  final secondStepFormKey = GlobalKey<FormState>();

  //!Page controller
  final pageController = PageController();
  final _currentIndex = Observable<int>(0);
  Observable<int> get currentIndex => _currentIndex;

  //! Input Controllers
  late final List<InputControl> inputControllers;
  late final InputControl firstNmae;
  late final InputControl lasttNmae;
  late final InputControl email;
  late final InputControl password;
  late final InputControl confirmPassword;
  late final TextEditingController pinController;
  late final FocusNode pinFocusNode;

  //!observables
  final countryObs = Observable<Country>(
    Country(
      phoneCode: "216",
      countryCode: "TN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Tunisia",
      example: "20123456",
      displayName: "Tunisia (TN) [+216]",
      displayNameNoCountryCode: "Tunisia (TN)",
      e164Key: "216-TN-0",
    ),
  );
  final birthDateObs = Observable<DateTime>(DateTime(DateTime.now().year - 5));
  final genderObs = Observable<String>("M");
  final acceptedTerms = Observable(false);

  //! Event Callers
  void next() => add(NextStep(_currentIndex));
  void pinSubmit(String _) => add(NextStep(_currentIndex));
  void previous() => add(PreviousStep(_currentIndex));
  void resendPin() => add(ResendPin(email.getText()));

  SignUpBloc(this._signUpDataSource) : super(Idle(), debugginEnabled: true) {
    on<SignUpWithEmailAndPassword>(_signUpWithEmailAndPassword);
    on<NextStep>(_next);
    on<PreviousStep>(_previous);
    on<ResendPin>(_resendPin);
    on<ActivateAccount>(_activateAccount);
  }

  //@ LIFECYCLE
  @override
  void onInit() {
    inputControllers = InputControl.generate(6);
    email = inputControllers[0];
    password = inputControllers[1];
    confirmPassword = inputControllers[2];
    firstNmae = inputControllers[3];
    lasttNmae = inputControllers[4];
    pinController = inputControllers[5].controller;
    pinFocusNode = inputControllers[5].node;
    super.onInit();
  }

  @override
  void onDispose() {
    inputControllers.disposeAll();
    super.onDispose();
  }
}
