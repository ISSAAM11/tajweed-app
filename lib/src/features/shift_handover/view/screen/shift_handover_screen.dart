import '../../../../base/screens/exports.dart';
import '../../binding/shift_handover_deps.dart';
import '../../vm/bloc/shift_handover_bloc.dart';
import '../../vm/states/shift_handover_states.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/report_view_widget.dart';
import '../widgets/shift_handover_app_bar.dart';

final class ShiftHandoverScreen extends Feature<ShiftHandoverBloc, ShiftHandoverState> {
  static final path = "/shift-handover";

  ShiftHandoverScreen({super.key})
    : super(
        dependencies: ShiftHandoverDependencies().inject,
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
  Widget build(BuildContext context, ShiftHandoverState state) {
    return Scaffold(
      appBar: const ShiftHandoverAppBar(),
      body: switch (state) {
        Loading() => const LoadingWidget(),
        Error() => ShiftHandoverErrorWidget(state.message),
        Empty() => const ShiftHandoverEmptyWidget(),
        Success() => ReportViewWidget(state.shiftReport),
      },
    );
  }
}
