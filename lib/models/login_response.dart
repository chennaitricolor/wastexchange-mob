import 'api_response_exception.dart';

class LoginResponse {
  final bool auth;
  final String token;

  LoginResponse(this.auth, this.token);

  static LoginResponse fromJson(Map<String, dynamic> json) {
    bool auth = json['auth'];
    String token = json['token'];
    if (auth == null || token == null) {
      throw ApiResponseException(
          '\'auth\' or \'token\' key missing in LoginResponse');
    }
    return LoginResponse(auth, token);
  }
}
