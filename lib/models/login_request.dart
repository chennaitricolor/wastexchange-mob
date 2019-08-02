class LoginRequest {
  String loginId;
  String password;

  LoginRequest({
    this.loginId,
    this.password,
  });

  Map<String, dynamic> toMap() => {
    "loginId": loginId,
    "password": password,
  };
}
