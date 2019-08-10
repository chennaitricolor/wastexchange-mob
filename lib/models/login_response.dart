import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {

  LoginResponse({
    this.auth,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    auth: json['auth'],
    token: json['token'],
  );

  Map<String, dynamic> toJson() => {
    'auth': auth,
    'token': token,
  };

  bool auth;
  String token;

}