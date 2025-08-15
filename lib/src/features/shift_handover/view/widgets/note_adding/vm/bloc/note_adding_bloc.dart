import '../../../../../../../base/bloc/exports.dart';
import '../events/note_adding_events.dart';
import '../states/note_adding_states.dart';

export '../events/note_adding_events.dart';
export '../states/note_adding_states.dart';

class NoteAddingBloc extends BaseBloc<NoteAddingEvent, NoteAddingState> {
  //! Event Callers
  static const _addNoteEvent = AddNote();
  Future<void> addNote() async => add(_addNoteEvent);

  //= Listeners
  NoteAddingBloc() : super(Idle(), debugginEnabled: true) {
    on<AddNote>(_addNote);
  }

  //+ Handlers
  Future<void> _addNote(AddNote event, Emitter<NoteAddingState> emit) async {
    emit(Loading());

    await Future.delayed(const Duration(seconds: 1));

    emit(NoteAdded());
  }
}
