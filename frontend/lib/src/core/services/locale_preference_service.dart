import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:tajweed_ai/src/features/settings/vm/app_language.dart';

final class LocalePreferenceService {
  final CacheManager _cache;
  static const _kKey = 'app_locale';

  AppLanguage? _memory;

  LocalePreferenceService(this._cache);

  AppLanguage get() {
    if (_memory != null) return _memory!;

    final code = _cache.getString(_kKey);
    _memory = AppLanguage.fromCode(code);
    return _memory!;
  }

  Future<void> set(AppLanguage language) async {
    _memory = language;
    await _cache.setString(_kKey, language.code);
  }
}
