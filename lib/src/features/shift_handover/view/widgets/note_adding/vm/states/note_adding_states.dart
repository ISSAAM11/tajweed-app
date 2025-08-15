import 'package:equatable/equatable.dart';

sealed class NoteAddingState with EquatableMixin {
  const NoteAddingState();

  @override
  List<Object?> get props => [];
}

class Idle extends NoteAddingState {
  const Idle();
}

class Loading extends NoteAddingState {
  const Loading();
}

class NoteAdded extends NoteAddingState {
  const NoteAdded();
}
