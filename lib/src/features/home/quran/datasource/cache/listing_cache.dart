import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:generic_requester/generic_requester.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/cache/listing_codec.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/listing/quran_listing_datasource.dart';

final class ListingCache {
  final CacheManager _cache;
  static const _kKey = 'listing_data';

  ListingDataDto? _memory;

  ListingCache(this._cache);

  ListingDataDto? get() {
    if (_memory != null) return _memory;
    Debugger.blue('hello from ListingCache.get');
    final raw = _cache.getString(_kKey);
    Debugger.blue('hello from ListingCache.get after getting raw');
    if (raw != null) {
      Debugger.blue('hello from ListingCache.get after raw is not null');
      _memory = ListingCodec.fromJson(raw);
      Debugger.blue('hello from ListingCache.get after decoding json');
    }

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
