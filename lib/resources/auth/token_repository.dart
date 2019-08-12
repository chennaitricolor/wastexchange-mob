import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:synchronized/synchronized.dart';

import 'package:wastexchange_mobile/util/jwt_utils.dart';

/// Abstract implementation of TokenRepository.
///
/// TokenRepository can be used as base class for implementing the Authentication Token Functionality.
abstract class TokenRepository {

  Future<void> setToken(String token);

  Future<String> getToken();

  Future<void> setRefreshToken(String token);

  Future<String> _getRefreshToken();

  Future<void> deleteToken();

  Future<bool> isTokenExpired();

  Future<bool> refreshToken();
}

/// TokenRepository class specifically designed to handle JWT Token by validating JWT Token, Checking token expired, etc...
/// This uses a singleton pattern to ensure only one instance is available.
class JWTTokenRepository implements TokenRepository {

  factory JWTTokenRepository([FlutterSecureStorage secureStorage]) {
    final FlutterSecureStorage storage = secureStorage ??= FlutterSecureStorage();
    return _instance ??= JWTTokenRepository._internal(storage);
  }

  JWTTokenRepository._internal(FlutterSecureStorage secureStorage) {
    _secureStorage = secureStorage;
  }

  FlutterSecureStorage _secureStorage;

  static JWTTokenRepository _instance;

  static const _jwtTokenKey = 'jwt_token';

  static const _refreshTokenKey = 'refresh_token';

  final lock = Lock();

  String _jwtToken;

  String _refreshToken;

  @override
  Future<void> setToken(token) async {

    if(!JWTUtils.isValidJWTToken(token)) {
      throw Exception('Invalid JWT token');
    }

    _jwtToken = token;
    await _secureStorage.write(key: _jwtTokenKey, value: token);
  }

  @override
  Future<bool> refreshToken() async {
    if(_getRefreshToken() != null) {
      await lock.synchronized(() async {
        // Refresh token is not done on the API Side.
      });

      return false; // Refresh token is not done on API Side. so return false.
    }

    return false;
  }

  @override
  Future<bool> isTokenExpired() async {

    final jwtToken = await getToken();

    final info = JWTUtils.parseJwtPayload(jwtToken);

    final int val = info['expireAt'];

    if(DateTime.now().millisecondsSinceEpoch > val + Duration(seconds: 60).inMilliseconds) {
      return true;
    }

    return false;
  }

  @override
  Future<void> deleteToken() async {
    _jwtToken = null;
    _refreshToken = null;
    await _secureStorage.delete(key: _jwtTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  @override
  Future<String> _getRefreshToken() async {
    return _refreshToken ??= await _secureStorage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> setRefreshToken(token) async {
    _refreshToken = token;
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<String> getToken() async {
    return _jwtToken ??= await _secureStorage.read(key: _jwtTokenKey);
  }
}