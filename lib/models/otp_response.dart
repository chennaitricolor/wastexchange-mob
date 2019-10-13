// TODO(Sayeed): Add asserts to constructor
class OtpResponse {
  OtpResponse({
    this.message,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        message: json['message'],
      );

  String message;
}
