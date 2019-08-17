import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.auth,
    this.token,
  }) {
    ArgumentError.checkNotNull(auth, 'auth key is missing in LoginResponse');
    ArgumentError.checkNotNull(token, 'token key is missing in LoginResponse');
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final auth = json['auth'];
    final token = json['token'];
    return LoginResponse(
      auth: auth,
      token: token,
    );
  }

  Map<String, dynamic> toJson() => {
        'auth': auth,
        'token': token,
      };

  bool auth;
  String token;
}
