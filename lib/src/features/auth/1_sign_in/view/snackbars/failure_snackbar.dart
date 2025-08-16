import '../../../../../base/screens/exports.dart';

class FailureSnackbar extends CommonSnackbar {
  FailureSnackbar({required super.message})
    : super(
        type: SnackbarType.error,
        actionTitle: 'Retry',
        // onActionPressed: () => context.read<SignInBloc>().add(GetShiftReport("3")),
      );
}
