class LoginData {
  LoginData({
    this.loginId,
    this.password,
  });

  String loginId;
  String password;

  Map<String, dynamic> toMap() => {
        'loginId': loginId,
        'password': password,
      };
}
