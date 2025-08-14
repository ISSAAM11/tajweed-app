import '../../../../base/screens/exports.dart';
import '../../binding/shift_handover_deps.dart';
import '../../bloc/shift_handover_bloc.dart';
import '../../bloc/states/shift_handover_states.dart';
import '../snackbars/_index.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/report_view_widget.dart';
import '../widgets/shift_handover_app_bar.dart';

final class ShiftHandoverScreen extends BlocProviderWidget<ShiftHandoverBloc> {
  static final path = "/shift-handover";

  ShiftHandoverScreen({super.key})
    : super(
        dependencies: ShiftHandoverDependencies(),
        debugStateChanges: true,
        fullRebuildWhen: (_, currentState) => false,
        updateWhen: (previous, current) => current is! Loading,
        onUpdate: (context, state) => switch (state) {
          Empty() => appMessenger.showSnackBar(
            WarningSnackbar(message: "No shift report found", context: context),
          ),
          Success() => appMessenger.showSnackBar(
            SuccessSnackbar(state.shiftReport.notes, context: context),
          ),
          Error() => appMessenger.showSnackBar(
            FailureSnackbar(message: state.message, context: context),
          ),
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context) {
    Debugger.black('ShiftHandoverScreen rebuilt');

    return Scaffold(
      appBar: const ShiftHandoverAppBar(),
      body: BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
        builder: (context, state) => switch (state) {
          Loading() => const LoadingWidget(),
          Error() => ShiftHandoverErrorWidget(state.message),
          Empty() => const ShiftHandoverEmptyWidget(),
          Success() => ReportViewWidget(state.shiftReport),
        },
      ),
    );
  }
}
