import 'package:equatable/equatable.dart';

import 'app_language.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeLanguageEvent extends SettingsEvent {
  final AppLanguage language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object?> get props => [language];
}
