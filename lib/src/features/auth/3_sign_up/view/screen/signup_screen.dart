import 'package:tajweed_ai/src/features/auth/3_sign_up/view/snackbars/warning_snackbar.dart';

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
            WarningSnackbar(message: state.message),
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
