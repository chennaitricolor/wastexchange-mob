import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
  AuthManager class manages user authentication token.
 */
class AuthManager {

  factory AuthManager() {
    return _instance;
  }

  AuthManager._internal();

  static final AuthManager _instance = AuthManager._internal();

  static const _accessTokenKey = 'access_token';

  void setAccessToken(accessToken) {
    FlutterSecureStorage().write(key: _accessTokenKey, value: accessToken);
  }

  Future<String> getAccessToken() async {
   return FlutterSecureStorage().read(key: _accessTokenKey);
  }
}