part of '../quran_bloc.dart';

extension on QuranBloc {
  Future<void> _loadChapters(
    LoadChaptersEvent event,
    Emitter<QuranState> emit,
  ) async {
    emit(QuranLoadingState());
    try {
      final chapters = await _datasource.getChapters();
      emit(QuranLoadedState(chapters));
    } catch (e) {
      emit(QuranErrorState(e.toString()));
    }
  }

  void _quranSurahSelectedEvent(
    QuranSurahSelectedEvent event,
    Emitter<QuranState> emit,
  ) {
    Debugger.green('Surah selected: ${event.surahId}');
  }
}
