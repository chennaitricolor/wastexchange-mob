import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  RegistrationResponse({
    this.success,
    this.message,
    this.auth,
    this.token,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        success: json['success'],
        message: json['message'],
        auth: json['auth'],
        token: json['token'],
      );

  bool success;
  String message;
  bool auth;
  String token;

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'auth': auth,
        'token': token,
      };
}
