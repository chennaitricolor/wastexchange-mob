import 'dart:convert';

String buyerBidDataToJson(dynamic data) => json.encode(data.toJson());

class BuyerBidData {
  BuyerBidData({
    this.details,
    this.sellerId,
    this.totalBid,
    this.pDateTime,
    this.contactName,
    this.status
  });

  var details;
  int sellerId;
  int totalBid;
  DateTime pDateTime;
  String contactName;
  String status;

  Map<String, dynamic> toMap() => {
    'details': details,
    'sellerId': sellerId,
    'totalBid': totalBid,
    'pDateTime': pDateTime,
    'contactName': contactName,
    'status': status,
  };
}