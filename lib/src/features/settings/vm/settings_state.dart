import 'package:equatable/equatable.dart';

import 'app_language.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

final class SettingsReady extends SettingsState {
  final AppLanguage language;

  const SettingsReady({required this.language});

  SettingsReady copyWith({AppLanguage? language}) =>
      SettingsReady(language: language ?? this.language);

  @override
  List<Object?> get props => [language];
}
