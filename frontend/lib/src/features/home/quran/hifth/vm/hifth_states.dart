part of 'hifth_bloc.dart';

sealed class HifthState extends Equatable {
  const HifthState();
  @override
  List<Object?> get props => [];
}

class HifthLoading extends HifthState {
  const HifthLoading();
}

class HifthLoaded extends HifthState {
  final ChapterHeaderDto header;
  final List<HifthAyah> ayahs;
  const HifthLoaded({required this.header, required this.ayahs});
  @override
  List<Object?> get props => [header.id, ayahs];
}

class HifthError extends HifthState {
  final String messageKey;
  const HifthError(this.messageKey);
  @override
  List<Object?> get props => [messageKey];
}

/// One ayah of the surah: its number and plain Arabic text.
class HifthAyah extends Equatable {
  final int number;
  final String text;
  const HifthAyah({required this.number, required this.text});
  @override
  List<Object?> get props => [number, text];
}
