import '../../../../base/screens/exports.dart';
import '../../bloc/events/shift_handover_events.dart';
import '../../bloc/shift_handover_bloc.dart';

class FailureSnackbar extends CommonSnackbar {
  FailureSnackbar({required super.context, required super.message})
    : super(
        type: SnackbarType.error,
        actionTitle: 'Retry',
        onActionPressed: () => context.read<ShiftHandoverBloc>().add(GetShiftReport("3")),
      );
}
