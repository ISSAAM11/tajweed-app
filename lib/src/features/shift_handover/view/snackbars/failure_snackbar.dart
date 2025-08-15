import '../../../../base/screens/exports.dart';
import '../../vm/bloc/shift_handover_bloc.dart';
import '../../vm/events/shift_handover_events.dart';

class FailureSnackbar extends CommonSnackbar {
  FailureSnackbar({required BuildContext context, required super.message})
    : super(
        type: SnackbarType.error,
        actionTitle: 'Retry',
        onActionPressed: () => context.read<ShiftHandoverBloc>().add(GetShiftReport("3")),
      );
}
