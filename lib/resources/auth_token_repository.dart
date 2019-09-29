import 'package:wastexchange_mobile/launch_setup.dart';
import 'package:wastexchange_mobile/utils/cached_secure_storage.dart';

class TokenRepository implements SetUpCompliant {
  factory TokenRepository() {
    return _singleton;
  }

// TODO(Sayeed): Do we need this test init. Can we test it differently.
  factory TokenRepository.testInit([CachedSecureStorage cachedSecureStorage]) {
    return TokenRepository._internal(cachedSecureStorage);
  }

  TokenRepository._internal([CachedSecureStorage cachedSecureStorage]) {
    _cachedSecureStorage = cachedSecureStorage ?? CachedSecureStorage();
  }

  static final TokenRepository _singleton = TokenRepository._internal();
  static const _ktoken = 'token';

  CachedSecureStorage _cachedSecureStorage;
  String token;

  bool isAuthorized() {
    return token != null;
  }

  Future<void> setToken(token) async {
    this.token = token;
    await _cachedSecureStorage.setValue(_ktoken, token);
  }

  Future<void> deleteToken() async {
    token = null;
    await _cachedSecureStorage.deleteKey(_ktoken);
  }

  Future<String> getToken() async {
    token = await _cachedSecureStorage.getValue(_ktoken);
    return token;
  }

  @override
  Future<void> load() async {
    await getToken();
  }
}
