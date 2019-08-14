class OtpData {
  OtpData({
    this.emailId,
    this.mobileNo,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
        emailId: json['emailId'],
        mobileNo: json['mobileNo'],
      );

  String emailId;
  String mobileNo;

  Map<String, dynamic> toMap() => {
        'emailId': emailId,
        'mobileNo': mobileNo,
      };
}
