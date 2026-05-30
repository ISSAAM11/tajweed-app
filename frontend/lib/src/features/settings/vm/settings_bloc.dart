import 'package:tajweed_ai/src/app/locale/locale_bloc.dart';
import 'package:tajweed_ai/src/base/bloc/exports.dart';

import 'app_language.dart';
import 'settings_events.dart';
import 'settings_state.dart';

part 'usecases/change_language_uc.dart';

class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {
  final LocaleBloc _localeBloc;

  SettingsBloc(this._localeBloc)
    : super(
        SettingsReady(language: _localeBloc.state),
        debugginEnabled: true,
      ) {
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  void changeLanguage(AppLanguage language) =>
      add(ChangeLanguageEvent(language));
}
