import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse({this.auth, this.token, this.approved}) {
    ArgumentError.checkNotNull(auth, 'auth key is missing in LoginResponse');
    ArgumentError.checkNotNull(token, 'token key is missing in LoginResponse');
    ArgumentError.checkNotNull(
        approved, 'approved key is missing in LoginResponse');
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final auth = json['auth'];
    final token = json['token'];
    final approved = json['approved'];
    return LoginResponse(auth: auth, token: token, approved: approved);
  }

  final bool auth;
  final String token;
  final bool approved;

  bool get success => auth && approved;
}
