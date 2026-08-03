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
