part of 'hifth_bloc.dart';

sealed class HifthEvent extends Equatable {
  const HifthEvent();
  @override
  List<Object?> get props => [];
}

class LoadSurah extends HifthEvent {
  final int surah;
  const LoadSurah(this.surah);
  @override
  List<Object?> get props => [surah];
}

/// The user worked on [ayah] — currently raised when they play it. Moves the
/// hifth bookmark, which is tracked separately from the mushaf one.
class AyahRead extends HifthEvent {
  final int ayah;
  const AyahRead(this.ayah);
  @override
  List<Object?> get props => [ayah];
}
