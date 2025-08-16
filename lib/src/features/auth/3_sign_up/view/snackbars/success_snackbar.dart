import '../../../../../base/screens/exports.dart';

class SuccessSnackbar extends CommonSnackbar {
  SuccessSnackbar()
    : super(message: "Successfully signed in", type: SnackbarType.success);
}
