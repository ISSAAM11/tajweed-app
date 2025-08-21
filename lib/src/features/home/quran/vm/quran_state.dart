import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/app_database.dart';

sealed class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object?> get props => [];
}

final class QuranInitialState extends QuranState {}

final class QuranLoadingState extends QuranState {}

final class QuranLoadedState extends QuranState {
  final List<ChapterRow> chapters;

  const QuranLoadedState(this.chapters);

  @override
  List<Object?> get props => [chapters];
}

final class QuranErrorState extends QuranState {
  final String message;

  const QuranErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
