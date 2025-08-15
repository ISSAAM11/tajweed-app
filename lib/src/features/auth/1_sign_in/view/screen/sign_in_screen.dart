import '../../../../../base/screens/exports.dart';    
import '../../binding/sign_in_deps.dart';
import '../../vm/bloc/sign_in_bloc.dart';
import '../../vm/states/sign_in_states.dart';


final class SignInScreen extends Feature<SignInBloc, SignInState> {
  static final path = "/sign-in";

  SignInScreen({super.key})
    : super(
        dependencies: SignInDependencies().inject,
        // debugStateChanges: true,
        // fullRebuildWhen: (_, currentState) => false,
        // updateWhen: (previous, current) => current is! Loading,
        // onUpdate: (context, state) => switch (state) {
        //   Empty() => appMessenger.showSnackBar(WarningSnackbar(message: "No shift report found")),
        //   Success() => appMessenger.showSnackBar(SuccessSnackbar(state.shiftReport.notes)),
        //   Error() => appMessenger.showSnackBar(
        //     FailureSnackbar(message: state.message, context: context),
        //   ),
        //   _ => null,
        // },
      );

  @override
  Widget build(BuildContext context, SignInState state) {
    return Scaffold(
      // body: switch (state) {
      //   Loading() => const LoadingWidget(),
      //   Error() => const ShiftHandoverErrorWidget(state.message),
      //   Empty() => const ShiftHandoverEmptyWidget(),
      //   Success() => const ReportViewWidget(state.shiftReport),
      // },
    );
  }
}
