// TODO(Sayeed): Add asserts to constructor
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
}
