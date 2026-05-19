import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';

class FailureSnackbar extends CommonSnackbar {
  FailureSnackbar({required BuildContext context, required super.message})
    : super(
        type: SnackbarType.error,
        actionTitle: AppLocalizations.of(context)!.snackbarRetry,
      );
}
