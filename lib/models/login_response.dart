import 'dart:convert';

import 'package:wastexchange_mobile/models/api_exception.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {

  LoginResponse({
    this.auth,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final auth = json['auth'];
    final token = json['token'];
    if (auth == null || token == null) {
      throw InvalidResponseJSONException(
          '\'auth\' or \'token\' key missing in LoginResponse');
    }
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