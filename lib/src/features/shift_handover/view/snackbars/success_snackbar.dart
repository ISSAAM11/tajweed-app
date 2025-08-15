import '../../../../app/router/app_messenger.dart';
import '../../data/models/handover_note.dart';

class SuccessSnackbar extends CommonSnackbar {
  final List<HandoverNote> handoverNotes;

  SuccessSnackbar(this.handoverNotes)
    : super(
        message: "successfully loaded ${handoverNotes.length} notes",
        type: SnackbarType.success,
      );
}
