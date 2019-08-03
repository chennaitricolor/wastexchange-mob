class LoginData {
  String loginId;
  String password;

  LoginData({
    this.loginId,
    this.password,
  });

  Map<String, dynamic> toMap() => {
    "loginId": loginId,
    "password": password,
  };
}
