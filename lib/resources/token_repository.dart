import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// TokenRepository class specifically designed to handle JWT Token by validating JWT Token, Checking token expired, etc...
/// This uses a singleton pattern to ensure only one instance is available.
class TokenRepository {
  factory TokenRepository([FlutterSecureStorage secureStorage]) {
    final FlutterSecureStorage storage =
        secureStorage ??= FlutterSecureStorage();
    return _instance ??= TokenRepository._internal(storage);
  }

  TokenRepository._internal(FlutterSecureStorage secureStorage) {
    _secureStorage = secureStorage;
  }

  FlutterSecureStorage _secureStorage;

  static TokenRepository _instance;

  static const _tokenKey = 'token';

  String _jwtToken;

  @override
  Future<bool> isAuthorized() async {
    return await getToken() != null;
  }

  Future<void> setToken(token) async {
    _jwtToken = token;
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    _jwtToken = null;
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<String> getToken() async {
    return _jwtToken ??= await _secureStorage.read(key: _tokenKey);
  }
}
