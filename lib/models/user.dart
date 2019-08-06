import 'dart:convert';

class User {
  User({
    this.id,
    this.city,
    this.pinCode,
    this.persona,
    this.address,
    this.mobNo,
    this.altMobNo,
    this.createdAt,
    this.updatedAt,
    this.lat,
    this.long,
    this.emailId,
    this.name,
    this.loginId,
  });

  int id;
  String city;
  int pinCode;
  String persona;
  String address;
  dynamic mobNo;
  dynamic altMobNo;
  DateTime createdAt;
  DateTime updatedAt;
  double lat;
  double long;
  String emailId;
  String name;
  String loginId;

  static List<User> fromJson(String str) {
    return List<User>.from(json.decode(str).map((x) => User._fromJson(x)));
  }

  static User _fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      city: json['city'],
      pinCode: json['pinCode'],
      persona: json['persona'],
      address: json['address'],
      mobNo: json['mobNo'],
      altMobNo: json['altMobNo'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
      emailId: json['emailId'],
      name: json['name'],
      loginId: json['loginId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'pinCode': pinCode,
        'persona': persona,
        'address': address,
        'mobNo': mobNo,
        'altMobNo': altMobNo,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'lat': lat,
        'long': long,
        'emailId': emailId,
        'name': name,
        'loginId': loginId,
      };
}
