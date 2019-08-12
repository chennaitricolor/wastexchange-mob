import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
  AuthManager class manages user authentication token.
 */
class AuthRepository {

  factory AuthRepository([FlutterSecureStorage secureStorage]) {
    final FlutterSecureStorage storage = secureStorage ??= FlutterSecureStorage();
    return _instance ??= AuthRepository._internal(storage);
  }

  AuthRepository._internal(FlutterSecureStorage secureStorage) {
    _secureStorage = secureStorage;
  }

  FlutterSecureStorage _secureStorage;

  static AuthRepository _instance;

  static const _accessTokenKey = 'access_token';

  String _accessToken;

  Future<void> setAccessToken(accessToken) async {
    _accessToken = accessToken;
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<String> getAccessToken() async {
   return _accessToken ??= await _secureStorage.read(key: _accessTokenKey);
  }

  ///  To be called on user logout from the app
  Future<void> deleteToken() async {
    _accessToken = null;
    await _secureStorage.delete(key: _accessTokenKey);
  }
}