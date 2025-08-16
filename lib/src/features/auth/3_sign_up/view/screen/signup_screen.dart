import '../../../../../base/screens/exports.dart';
import '../../../2_sign_in/router/sign_in_route.dart';
// import '../widgets/signup_stepper.dart';

import '../../binding/sign_up_deps.dart';
import '../../vm/bloc/sign_up_bloc.dart';
import '../../vm/states/sign_up_states.dart';

class SignUpScreen extends Feature<SignUpBloc, SignUpState> {
  SignUpScreen({super.key}) : super(dependencies: SignUpDependencies().inject);

  @override
  Widget build(BuildContext context, SignUpState state) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          globalContext.go(signInRoute.path);
        },
        child: Text("Sign In"),
      ),
      // body: SignupStepper(state),
    );
  }
}
