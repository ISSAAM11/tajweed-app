import '../../../../app/router/app_messenger.dart';
import '../../data/models/handover_note.dart';

class SuccessSnackbar extends CommonSnackbar {
  final List<HandoverNote> handoverNotes;

  SuccessSnackbar(this.handoverNotes, {required super.context})
    : super(
        message: "successfully loaded ${handoverNotes.length} notes",
        type: SnackbarType.success,
      );
}
