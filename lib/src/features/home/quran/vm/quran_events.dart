import 'package:equatable/equatable.dart';

sealed class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

final class LoadChaptersEvent extends QuranEvent {}

final class SelectSurahEvent extends QuranEvent {
  final int surahId;

  const SelectSurahEvent(this.surahId);

  @override
  List<Object> get props => [surahId];
}

final class ListWithJuz extends QuranEvent {
  const ListWithJuz();
}
