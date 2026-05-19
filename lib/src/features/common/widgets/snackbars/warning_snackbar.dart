import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

class WarningSnackbar extends CommonSnackbar {
  WarningSnackbar({required BuildContext context, required super.message})
    : super(
        type: SnackbarType.warning,
        actionTitle: AppLocalizations.of(context)!.snackbarOk,
        defaultCloseButton: false,
      );
}
