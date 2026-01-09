import 'dart:convert';

import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

final class LastSelectedSurahService {
  final CacheManager _cache;
  static const _kKey = 'last_selected_surah';

  ChapterItem? _memory;

  LastSelectedSurahService(this._cache);

  ChapterItem? get() {
    if (_memory != null) return _memory;

    final raw = _cache.getString(_kKey);
    if (raw == null) return null;

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      _memory = ChapterItem.fromMap(map);
    } catch (e) {
      return null;
    }

    return _memory;
  }

  Future<void> set(ChapterItem chapter) async {
    _memory = chapter;
    final json = jsonEncode(chapter.toMap());
    await _cache.setString(_kKey, json);
  }

  void clear() {
    _memory = null;
    _cache.remove(_kKey);
  }
}
