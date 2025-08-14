import '../../../../../base/screens/exports.dart';
import '../../binding/sign_in_deps.dart';
import '../../bloc/sign_in_bloc.dart';
import '../../bloc/states/sign_in_states.dart';
// import '../../bloc/states/shift_handover_states.dart';
// import '../snackbars/_index.dart';
// import '../widgets/empty_state_widget.dart';
// import '../widgets/error_widget.dart';
// import '../widgets/loading_widget.dart';
// import '../widgets/report_view_widget.dart';
// import '../widgets/shift_handover_app_bar.dart';

final class SignInScreen extends BlocProviderWidget<SignInBloc> {
  static final path = "/sign-in";

  SignInScreen({super.key})
    : super(
        dependencies: SignInDependencies(),
        // debugStateChanges: true,
        // fullRebuildWhen: (_, currentState) => false,
        // updateWhen: (previous, current) => current is! Loading,
        // onUpdate: (context, state) => switch (state) {
        //   Empty() => appMessenger.showSnackBar(
        //     WarningSnackbar(message: "No shift report found", context: context),
        //   ),
        //   Success() => appMessenger.showSnackBar(
        //     SuccessSnackbar(state.shiftReport.notes, context: context),
        //   ),
        //   Error() => appMessenger.showSnackBar(
        //     FailureSnackbar(message: state.message, context: context),
        //   ),
        //   _ => null,
        // },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) => switch (state) {
          SignInInitial() => Container(color: Colors.red),
          Loading() => Container(color: Colors.red),
          Error() =>  Container(color: Colors.red),
          Success() =>  Container(color: Colors.red),
        },
      ),
    );
  }
}
