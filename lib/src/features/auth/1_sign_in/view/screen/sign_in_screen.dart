import '../../../../../base/screens/exports.dart';
import '../../binding/sign_in_deps.dart';
import '../../vm/bloc/sign_in_bloc.dart';
import '../../vm/states/sign_in_states.dart';
import '../snackbars/_index.dart';
import '../widgets/sign_in_body.dart';

final class SignInScreen extends Feature<SignInBloc, SignInState> {
  SignInScreen({super.key})
    : super(
        dependencies: SignInDependencies().inject,
        onUpdate: (context, state) =>switch (state) {
          Success() => appMessenger.showSnackBar(SuccessSnackbar()),
          Error() => appMessenger.showSnackBar(FailureSnackbar(message: state.message)),
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, SignInState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body:SignInBody(state),
    );  
  }

}

