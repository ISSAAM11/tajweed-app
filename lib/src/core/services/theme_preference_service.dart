import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:tajweed_ai/src/app/theme/app_theme_mode.dart';

final class ThemePreferenceService {
  final CacheManager _cache;
  static const _kKey = 'app_theme_mode';

  AppThemeMode? _memory;

  ThemePreferenceService(this._cache);

  AppThemeMode get() {
    if (_memory != null) return _memory!;

    final code = _cache.getString(_kKey);
    _memory = AppThemeMode.fromCode(code);
    return _memory!;
  }

  Future<void> set(AppThemeMode mode) async {
    _memory = mode;
    await _cache.setString(_kKey, mode.code);
  }
}
