import 'package:equatable/equatable.dart';

sealed class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

final class LoadChaptersEvent extends QuranEvent {}

final class QuranSurahSelectedEvent extends QuranEvent {
  final int surahId;

  const QuranSurahSelectedEvent(this.surahId);

  @override
  List<Object> get props => [surahId];
}

final class ListWithJuz extends QuranEvent {
  const ListWithJuz();
}
