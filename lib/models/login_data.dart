class LoginData {
  LoginData({
    this.loginId,
    this.password,
  });

  final String loginId;
  final String password;

  Map<String, dynamic> toMap() => {
        'loginId': loginId,
        'password': password,
      };
}
