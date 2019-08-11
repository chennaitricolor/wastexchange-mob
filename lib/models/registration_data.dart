import 'dart:convert';

RegistrationData registrationDataFromJson(String str) =>
    RegistrationData.fromJson(json.decode(str));

String registrationDataToJson(RegistrationData data) =>
    json.encode(data.toJson());

class RegistrationData {
  RegistrationData({
    this.city,
    this.emailId,
    this.password,
    this.name,
    this.pinCode,
    this.mobNo,
    this.altMobNo,
    this.lat,
    this.long,
    this.persona,
    this.address,
    this.otp,
  });

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(
        city: json['city'],
        emailId: json['emailId'],
        password: json['password'],
        name: json['name'],
        pinCode: json['pinCode'],
        mobNo: json['mobNo'],
        altMobNo: json['altMobNo'],
        lat: json['lat'],
        long: json['long'],
        persona: json['persona'],
        address: json['address'],
        otp: json['otp'],
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'emailId': emailId,
        'password': password,
        'name': name,
        'pinCode': pinCode,
        'mobNo': mobNo,
        'altMobNo': altMobNo,
        'lat': lat,
        'long': long,
        'persona': persona,
        'address': address,
        'otp': otp,
      };

  String city;
  String emailId;
  String password;
  String name;
  int pinCode;
  int mobNo;
  int altMobNo;
  double lat;
  double long;
  String persona;
  String address;
  int otp;
}
