import '../../../../../base/screens/exports.dart';
import '../widgets/signup_body.dart';

import '../../binding/sign_up_deps.dart';
import '../../vm/bloc/sign_up_bloc.dart';
import '../../vm/states/sign_up_states.dart';

class SignUpScreen extends Feature<SignUpBloc, SignUpState> {
  SignUpScreen({super.key})
    : super(
        dependencies: SignUpDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          Error() => appMessenger.showSnackBar(
            WarningSnackbar(context: context, message: state.message),
          ),
          ResendPinSuccess() => appMessenger.showSnackBar(
            SuccessSnackbar(message: state.message),
          ),
          Success() => appMessenger.showSnackBar(
            SuccessSnackbar(message: state.message),
          ),
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, SignUpState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SignupBody(state),
    );
  }
}
