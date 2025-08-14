import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../app/binding/app_bindings.dart';

mixin SecureCachingMixin {
  FlutterSecureStorage get secureActor => get<FlutterSecureStorage>();

  Future<String?> getSecureString(String key) async => secureActor.read(key: key);

  Future<bool> setSecureString(String key, String value) async {
    await secureActor.write(key: key, value: value);
    return true;
  }

  Future<bool> removeSecureKey(String key) async {
    await secureActor.delete(key: key);
    return true;
  }

  Future<bool> clearSecure() async {
    await secureActor.deleteAll();
    return true;
  }

  Future<bool> containsSecureKey(String key) async => secureActor.containsKey(key: key);

  Future<Set<String>> getSecureKeys() async {
    final allData = await secureActor.readAll();
    return allData.keys.toSet();
  }

  // Méthodes asynchrones pour l'utilisation réelle avec FlutterSecureStorage
  Future<String?> getStringAsync(String key) async => secureActor.read(key: key);

  Future<int?> getIntAsync(String key) async {
    final value = await secureActor.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  Future<bool?> getBoolAsync(String key) async {
    final value = await secureActor.read(key: key);
    return value != null ? value == 'true' : null;
  }

  Future<double?> getDoubleAsync(String key) async {
    final value = await secureActor.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  Future<List<String>?> getStringListAsync(String key) async {
    final value = await secureActor.read(key: key);
    if (value == null) return null;
    try {
      return value.split(',');
    } catch (e) {
      return null;
    }
  }

  Future<bool> containsKeyAsync(String key) async => secureActor.containsKey(key: key);

  Future<Set<String>> getKeysAsync() async {
    final allData = await secureActor.readAll();
    return allData.keys.toSet();
  }
}
