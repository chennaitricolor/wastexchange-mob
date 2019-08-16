import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      {this.id,
      this.city,
      this.pinCode,
      this.persona,
      this.address,
      this.mobNo,
      this.altMobNo,
      this.lat,
      this.long,
      this.emailId,
      this.name,
      this.approved});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        city: json['city'],
        pinCode: json['pinCode'],
        persona: json['persona'],
        address: json['address'],
        mobNo: json['mobNo'],
        altMobNo: json['altMobNo'],
        lat: json['lat'].toDouble(),
        long: json['long'].toDouble(),
        emailId: json['emailId'],
        name: json['name'],
        approved: json['approved'],
      );

  int id;
  String city;
  int pinCode;
  String persona;
  String address;
  String mobNo;
  String altMobNo;
  double lat;
  double long;
  String emailId;
  String name;
  bool approved;

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'pinCode': pinCode,
        'persona': persona,
        'address': address,
        'mobNo': mobNo,
        'altMobNo': altMobNo,
        'lat': lat,
        'long': long,
        'emailId': emailId,
        'name': name,
        'approved': approved,
      };
}
