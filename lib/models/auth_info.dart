
class AuthInfo {
  static final AuthInfo _authDetails = new AuthInfo._internal();

  String authenticationToken;

  factory AuthInfo() {
    return _authDetails;
  }

  AuthInfo._internal();
}