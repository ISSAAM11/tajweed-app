part of '../home_screen_bloc.dart';

extension on HomeScreenBloc {
  void _refresh(RefreshHomeEvent event, Emitter<HomeScreenState> emit) {
    final current = state;
    final nextTick = current is HomeReady ? current.refreshTick + 1 : 0;
    emit(
      HomeReady(
        lastSelected: _lastSurahService.get(),
        refreshTick: nextTick,
      ),
    );
  }
}
