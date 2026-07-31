import 'dart:collection';

import 'package:cg_core_defs/strategies/cache/cache_manager.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

import 'page_codec.dart';

class PageCache {
  final CacheManager cacheManager;
  final int capacity;
  // ignore: prefer_collection_literals
  final _memoryCache = LinkedHashMap<int, PageContentDto>();

  PageCache({
    required this.cacheManager,
    this.capacity = 10, // keep 10 pages in-memory
  });

  // Keep in sync with `_purgeDbDerivedCaches` in database/app_database.dart,
  // which drops these entries when the prebuilt DB is refreshed.
  String _kPageKey(int pageNo) => 'page:$pageNo';

  /// Get a page (tries memory → cacheManager → returns null if not found).
  PageContentDto? get(int pageNo) {
    // 1. Check memory LRU
    final mem = _memoryCache[pageNo];
    if (mem != null) {
      _touch(pageNo, mem);
      return mem;
    }
    // 2. Check persistent cache
    final raw = cacheManager.getString(_kPageKey(pageNo));
    if (raw != null) {
      final page = PageCodec.fromJson(raw);
      _putMemory(pageNo, page);
      return page;
    }

    return null;
  }

  /// Store a page in both memory + persistent cache.
  Future<void> set(PageContentDto page) async {
    _putMemory(page.pageNo, page);
    await cacheManager.setString(
      _kPageKey(page.pageNo),
      PageCodec.toJson(page),
    );
  }

  /// Evict everything this cache owns (memory + its own `page:` entries).
  ///
  /// Only `page:` keys are removed — the same store holds user data (marked
  /// ayahs, theme, locale, cheikh) that must survive a page-cache eviction.
  Future<void> clear() async {
    _memoryCache.clear();
    final pageKeys = cacheManager
        .getKeys()
        .where((k) => k.startsWith('page:'))
        .toList();
    for (final key in pageKeys) {
      await cacheManager.remove(key);
    }
  }

  /// Dispose only clears memory cache.
  void dispose() {
    _memoryCache.clear();
  }

  // --- internal helpers ---

  void _putMemory(int pageNo, PageContentDto page) {
    _memoryCache[pageNo] = page;
    _touch(pageNo, page);

    // Enforce LRU capacity
    if (_memoryCache.length > capacity) {
      _memoryCache.remove(_memoryCache.keys.first);
    }
  }

  void _touch(int key, PageContentDto value) {
    _memoryCache.remove(key);
    _memoryCache[key] = value;
  }
}
