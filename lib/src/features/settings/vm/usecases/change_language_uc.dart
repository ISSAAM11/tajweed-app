part of '../settings_bloc.dart';

extension on SettingsBloc {
  Future<void> _changeLanguage(
    ChangeLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final current = state;
    if (current is SettingsReady && current.language == event.language) return;
    await _localeBloc.change(event.language);
    emit(SettingsReady(language: event.language));
  }
}
