import '../../../../base/screens/exports.dart';

class WarningSnackbar extends CommonSnackbar {
  WarningSnackbar({required super.message})
    : super(type: SnackbarType.warning, actionTitle: 'Ok', defaultCloseButton: false);
}
