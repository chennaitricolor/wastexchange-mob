// TODO(Sayeed): Think of a better name

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wastexchange_mobile/launch_setup.dart';

// TODO(Sayeed): We have different naming conventions for interface/implementation design pattern. This class is different from ConnectivityEvent. Need consistency.
abstract class KeyValueDataStoreInterface {
  Future<void> setBool(bool value, String key);
  Future<void> setInt(int value, String key);
  Future<void> setDouble(double value, String key);
  Future<void> setString(String value, String key);

  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
  String getString(String key);

  void remove(String key);
}

// TODO(Sayeed): Should we move all code to this abstract interface paradigm and coding to interface
class KeyValueDataStore
    implements KeyValueDataStoreInterface, LaunchSetupMember {
  factory KeyValueDataStore() {
    return _singleton;
  }

  KeyValueDataStore._internal();

  static final KeyValueDataStore _singleton = KeyValueDataStore._internal();
  SharedPreferences _preferences;

  @override
  bool getBool(String key) {
    return _preferences.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _preferences.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _preferences.getInt(key);
  }

  @override
  String getString(String key) {
    return _preferences.getString(key);
  }

  @override
  Future<void> setBool(bool value, String key) async {
    await _preferences.setBool(key, value);
  }

  @override
  Future<void> setDouble(double value, String key) async {
    await _preferences.setDouble(key, value);
  }

  @override
  Future<void> setInt(int value, String key) async {
    await _preferences.setInt(key, value);
  }

  @override
  Future<void> setString(String value, String key) async {
    await _preferences.setString(key, value);
  }

  @override
  void remove(String key) {
    _preferences.remove(key);
  }

  @override
  Future<void> load() async {
    _preferences = await SharedPreferences.getInstance();
  }
}
