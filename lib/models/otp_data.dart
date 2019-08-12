
class OtpData {

  OtpData({
    this.emailId,
    this.mobileNo,
  });
  String emailId;
  String mobileNo;

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    emailId: json['emailId'],
    mobileNo: json['mobileNo'],
  );

  Map<String, dynamic> toMap() => {
    'emailId': emailId,
    'mobileNo': mobileNo,
  };
}
