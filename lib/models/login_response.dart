import 'api_response_exception.dart';

class LoginResponse {
  final bool auth;
  final String token;
  final bool approved;

  bool get success => auth && approved;

  LoginResponse(this.auth, this.token, this.approved);

//TODO: Add test for success, approved when the api response is ready
  static LoginResponse fromJson(Map<String, dynamic> json) {
    bool auth = json['auth'];
    String token = json['token'];
    if (auth == null || token == null) {
      throw ApiResponseException(
          '\'auth\' or \'token\' key missing in LoginResponse');
    }
    return LoginResponse(auth, token, true);
  }
}
