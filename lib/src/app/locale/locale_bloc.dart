import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tajweed_ai/src/core/services/locale_preference_service.dart';
import 'package:tajweed_ai/src/features/settings/vm/app_language.dart';

class LocaleBloc extends Cubit<AppLanguage> {
  final LocalePreferenceService _prefs;

  LocaleBloc(this._prefs) : super(_prefs.get());

  Future<void> change(AppLanguage language) async {
    if (state == language) return;
    await _prefs.set(language);
    emit(language);
  }
}
