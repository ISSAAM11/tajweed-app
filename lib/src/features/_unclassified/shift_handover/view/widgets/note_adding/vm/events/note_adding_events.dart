import 'package:equatable/equatable.dart';

sealed class NoteAddingEvent with EquatableMixin {
  const NoteAddingEvent();

  @override
  List<Object?> get props => [];
}

class AddNote extends NoteAddingEvent {
  const AddNote();
}
