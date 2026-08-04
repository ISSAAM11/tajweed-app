import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_codec.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

final class ListingCache {
  final CacheManager _cache;

  // Keep in sync with `_purgeDbDerivedCaches` in database/app_database.dart,
  // which drops this entry when the prebuilt DB is refreshed.
  static const _kKey = 'listing_data_v3';

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

/// Where the user left off, tracked once per [LastReadSource] so the mushaf and
/// the hifth screen keep independent bookmarks.
///
/// These are user data, not derived cache — neither key may be dropped by
/// `_purgeDbDerivedCaches` in `database/app_database.dart`.
final class LastSelectedSurahService {
  final CacheManager _cache;

  /// The mushaf key predates the hifth flow, so it keeps its original name and
  /// its existing payload stays readable.
  static const _kKeys = <LastReadSource, String>{
    LastReadSource.quranPage: 'last_selected_page',
    LastReadSource.hifth: 'last_selected_page_hifth',
  };

  final Map<LastReadSource, LastSelectedPage> _memory = {};
  final Set<LastReadSource> _loaded = {};

  /// Bumped on every write. Screens read through a [ValueListenableBuilder] so
  /// the card refreshes when the user pops back after reading, instead of
  /// showing the value captured when the screen was first built.
  final ValueNotifier<int> revision = ValueNotifier(0);

  LastSelectedSurahService(this._cache);

  LastSelectedPage? get([LastReadSource source = LastReadSource.quranPage]) {
    if (_loaded.add(source)) {
      final raw = _cache.getString(_kKeys[source]!);
      if (raw != null) {
        _memory[source] = ListingCodec.lastSelectedPageFromJson(raw);
      }
    }
    return _memory[source];
  }

  /// The more recently saved of the two, for the home screen's single card.
  /// Legacy mushaf entries have `savedAt == 0`, so any hifth entry outranks
  /// them until the mushaf is opened again — acceptable, since the alternative
  /// is inventing a timestamp we never recorded.
  LastSelectedPage? mostRecent() {
    final entries = [
      for (final source in LastReadSource.values) get(source),
    ].nonNulls.toList();
    if (entries.isEmpty) return null;
    entries.sort((a, b) => b.savedAt.compareTo(a.savedAt));
    return entries.first;
  }

  Future<void> set(LastSelectedPage page) async {
    _loaded.add(page.source);
    _memory[page.source] = page;
    revision.value++;
    await _cache.setString(
      _kKeys[page.source]!,
      ListingCodec.lastSelectedPageToJson(page),
    );
  }

  void clear() {
    _memory.clear();
    _loaded.clear();
    revision.value++;
    for (final key in _kKeys.values) {
      _cache.remove(key);
    }
  }
}
