import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:flutter/foundation.dart';

/// Persists the ayahs the user marked, as `"surah:ayah"` strings.
///
/// Marks are user data, not derived cache — [_kKey] must never be dropped by
/// the DB-derived cache purges (see `_purgeDbDerivedCaches` in
/// `database/app_database.dart` and `PageCache.clear`).
///
/// [marks] broadcasts the current set so every live `PageViewer` (the PageView
/// keeps neighbouring pages alive) repaints when a mark is toggled — an ayah
/// can straddle a page boundary.
final class MarkedAyahService {
  final CacheManager _cache;
  static const _kKey = 'marked_ayahs_v1';

  final ValueNotifier<Set<String>> marks = ValueNotifier(const {});
  bool _loaded = false;

  MarkedAyahService(this._cache);

  static String keyOf(int surah, int ayah) => '$surah:$ayah';

  /// Current marks, loading them from storage on first access.
  Set<String> get current {
    _ensureLoaded();
    return marks.value;
  }

  bool isMarked(int surah, int ayah) => current.contains(keyOf(surah, ayah));

  Future<void> toggle(int surah, int ayah) async {
    final key = keyOf(surah, ayah);
    // A new Set on every change — ValueNotifier only fires on identity change.
    final next = Set<String>.from(current);
    if (!next.remove(key)) next.add(key);
    marks.value = next;
    await _cache.setStringList(_kKey, next.toList());
  }

  Future<void> clear() async {
    _loaded = true;
    marks.value = const {};
    await _cache.remove(_kKey);
  }

  void _ensureLoaded() {
    if (_loaded) return;
    _loaded = true;
    final stored = _cache.getStringList(_kKey);
    if (stored != null && stored.isNotEmpty) {
      marks.value = stored.toSet();
    }
  }
}
