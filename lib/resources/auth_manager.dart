import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
  AuthManager class manages user authentication token.
 */
class AuthManager {

  static const _accessTokenKey = "access_token";

  AuthManager._internal();

  static final AuthManager _instance = new AuthManager._internal();

  factory AuthManager() {
    return _instance;
  }

  void setAccessToken(accessToken) {
    FlutterSecureStorage().write(key: _accessTokenKey, value: accessToken);
  }

  Future<String> getAccessToken() async {
   return FlutterSecureStorage().read(key: _accessTokenKey);
  }

}