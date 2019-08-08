import 'api_exception.dart';

class LoginResponse {
  LoginResponse(this.auth, this.token, this.approved);

  final bool auth;
  final String token;
  final bool approved;
  bool get success => auth && approved;

// TODO(Sayeed): Add test for success, approved when the api response is ready
  static LoginResponse fromJson(Map<String, dynamic> json) {
    final bool auth = json['auth'];
    final String token = json['token'];
    if (auth == null || token == null) {
      throw InvalidResponseJSONException(
          '\'auth\' or \'token\' key missing in LoginResponse');
    }
    return LoginResponse(auth, token, true);
  }
}
