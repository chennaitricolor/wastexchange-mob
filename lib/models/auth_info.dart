class AuthInfo {
  factory AuthInfo() {
    return _authDetails;
  }

  AuthInfo._internal();

  static final AuthInfo _authDetails = AuthInfo._internal();

  String authenticationToken;
}
