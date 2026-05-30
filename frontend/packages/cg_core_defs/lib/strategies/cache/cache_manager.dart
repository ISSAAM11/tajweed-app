/// Interface for cache management operations.
abstract class CacheManager<A> {
  /// The actor instance that will perform the cache operations.
  A get actor;

  /// Store a string value with the specified key.
  Future<bool> setString(String key, String value);

  /// Retrieve a string value for the specified key.
  String? getString(String key);

  /// Store an integer value with the specified key.
  Future<bool> setInt(String key, int value);

  /// Retrieve an integer value for the specified key.
  int? getInt(String key);

  /// Store a boolean value with the specified key.
  Future<bool> setBool(String key, bool value);

  /// Retrieve a boolean value for the specified key.
  bool? getBool(String key);

  /// Store a double value with the specified key.
  Future<bool> setDouble(String key, double value);

  /// Retrieve a double value for the specified key.
  double? getDouble(String key);

  /// Store a list of strings with the specified key.
  Future<bool> setStringList(String key, List<String> value);

  /// Retrieve a list of strings for the specified key.
  List<String>? getStringList(String key);

  /// Check if the cache contains a value for the specified key.
  bool containsKey(String key);

  /// Retrieve a set of all keys in the cache.
  Set<String> getKeys();

  /// Remove the value associated with the specified key.
  Future<bool> remove(String key);

  /// Clear all cache values.
  Future<bool> clear();
}
