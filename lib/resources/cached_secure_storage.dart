import 'dart:collection';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CachedSecureStorage {
  factory CachedSecureStorage([FlutterSecureStorage flutterSecureStorage]) {
    return _instance ?? CachedSecureStorage._internal(flutterSecureStorage);
  }

  CachedSecureStorage._internal([FlutterSecureStorage flutterSecureStorage]) {
    _flutterSecureStorage = flutterSecureStorage ?? FlutterSecureStorage();
  }

  static CachedSecureStorage _instance;

  FlutterSecureStorage _flutterSecureStorage;

  final Map<String, String> _cachedKeyValueMap = HashMap<String, String>();

  Future<void> setValue(String key, String value) async {
    _cachedKeyValueMap[key] = value;
    await _flutterSecureStorage.write(key: key, value: value);
  }

  Future<void> deleteKey(String key) async {
    _cachedKeyValueMap.remove(key);
    await _flutterSecureStorage.delete(key: key);
  }

  Future<String> getValue(String key) async {
    if (_cachedKeyValueMap[key] == null) {
      _cachedKeyValueMap[key] = await _flutterSecureStorage.read(key: key);
    }

    return _cachedKeyValueMap[key];
  }
}
