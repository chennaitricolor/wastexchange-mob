import 'package:wastexchange_mobile/utils/cached_secure_storage.dart';

/// TokenRepository class specifically designed to handle JWT Token by validating JWT Token, Checking token expired, etc...
/// This uses a singleton pattern to ensure only one instance is available.
class TokenRepository {
  factory TokenRepository() {
    return _singleton;
  }

  factory TokenRepository.testInit([CachedSecureStorage cachedSecureStorage]) {
    return TokenRepository._internal(cachedSecureStorage);
  }

  TokenRepository._internal([CachedSecureStorage cachedSecureStorage]) {
    _cachedSecureStorage = cachedSecureStorage ?? CachedSecureStorage();
  }

  static final TokenRepository _singleton = TokenRepository._internal();

  CachedSecureStorage _cachedSecureStorage;

  static const _tokenKey = 'token';

  String token;

  bool isAuthorized() {
    return token != null;
  }

  Future<void> setToken(token) async {
    this.token = token;
    await _cachedSecureStorage.setValue(_tokenKey, token);
  }

  Future<void> deleteToken() async {
    token = null;
    await _cachedSecureStorage.setValue(_tokenKey, null);
  }

  Future<String> getToken() async {
    token = await _cachedSecureStorage.getValue(_tokenKey);
    return token;
  }

  Future<void> loadTokenFromCache() async {
    await getToken();
  }
}
