import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';
import 'package:tajweed_ai/src/core/services/theme_preference_service.dart';

class ThemeBloc extends Cubit<AppThemeMode> {
  final ThemePreferenceService _prefs;

  ThemeBloc(this._prefs) : super(_prefs.get());

  Future<void> change(AppThemeMode mode) async {
    if (state == mode) return;
    await _prefs.set(mode);
    emit(mode);
  }

  Future<void> toggle() => change(
    state == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark,
  );
}
