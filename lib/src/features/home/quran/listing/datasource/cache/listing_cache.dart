import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_codec.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

final class ListingCache {
  final CacheManager _cache;
  static const _kKey = 'listing_data';

  ListingDataDto? _memory;

  ListingCache(this._cache);

  ListingDataDto? get() {
    if (_memory != null) return _memory;

    final raw = _cache.getString(_kKey);

    if (raw != null) _memory = ListingCodec.fromJson(raw);

    return _memory;
  }

  Future<void> set(ListingDataDto dto) async {
    _memory = dto;
    await _cache.setString(_kKey, ListingCodec.toJson(dto));
  }

  void clear() {
    _memory = null;
    _cache.remove(_kKey);
  }
}

final class LastSelectedSurahService {
  final CacheManager _cache;
  static const _kKey = 'last_selected_page';

  LastSelectedPage? _memory;

  LastSelectedSurahService(this._cache);

  LastSelectedPage? get() {
    if (_memory != null) return _memory;

    final raw = _cache.getString(_kKey);
    if (raw != null) {
      _memory = ListingCodec.lastSelectedPageFromJson(raw);
    }

    return _memory;
  }

  Future<void> set(LastSelectedPage page) async {
    _memory = page;
    final json = ListingCodec.lastSelectedPageToJson(page);
    await _cache.setString(_kKey, json);
  }

  void clear() {
    _memory = null;
    _cache.remove(_kKey);
  }
}
