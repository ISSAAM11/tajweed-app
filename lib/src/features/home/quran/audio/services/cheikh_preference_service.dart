import 'package:cg_core_defs/strategies/cache/cache_manager.dart';

class CheikhPreferenceService {
  final CacheManager _cache;
  static const _kKey = 'selected_cheikh_id';
  static const _kDefault = 'ahmad-alnufais';

  String? _memory;

  CheikhPreferenceService(this._cache);

  String get() {
    if (_memory != null) return _memory!;
    _memory = _cache.getString(_kKey) ?? _kDefault;
    return _memory!;
  }

  Future<void> set(String cheikhId) async {
    _memory = cheikhId;
    await _cache.setString(_kKey, cheikhId);
  }
}
