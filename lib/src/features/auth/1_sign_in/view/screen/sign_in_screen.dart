import '../../../../../base/screens/exports.dart';    
import '../../binding/sign_in_deps.dart';
import '../../vm/bloc/sign_in_bloc.dart';
import '../../vm/states/sign_in_states.dart';
import '../snackbars/_index.dart';
import '../widgets/sign_in_body.dart';


final class SignInScreen extends Feature<SignInBloc, SignInState> {
  static final path = "/sign-in";

  SignInScreen({super.key})
    : super(
        dependencies: SignInDependencies().inject,
        onUpdate: (context, state) =>
          state is Success ? 
            appMessenger.showSnackBar(SuccessSnackbar()) : null,
      );

  @override
  Widget build(BuildContext context, SignInState state) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SignInBody(state),
    );  
  }

}

