import 'dart:convert';

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    this.message,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        message: json['message'],
      );

  String message;

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
