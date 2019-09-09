import 'dart:convert';

List<Bid> bidsFromJson(String str) =>
    List<Bid>.from(json.decode(str).map((x) => Bid.fromJson(x)));

class Bid {
  Bid(
      {this.orderId,
      this.createdDate,
      this.sellerId,
      this.amount,
      this.pickupDate,
      this.status,
      this.contactName,
      this.bidItems}) {
    ArgumentError.checkNotNull(orderId);
    ArgumentError.checkNotNull(createdDate);
    ArgumentError.checkNotNull(sellerId);
    ArgumentError.checkNotNull(amount);
    ArgumentError.checkNotNull(pickupDate);
    ArgumentError.checkNotNull(status);
    ArgumentError.checkNotNull(contactName);
    ArgumentError.checkNotNull(bidItems);
  }

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
      orderId: json['id'].toString(),
      createdDate: DateTime.parse(json['createdAt']),
      sellerId: json['sellerId'].toString(),
      amount: json['totalBid'].toDouble().toStringAsFixed(2),
      pickupDate: DateTime.parse(json['pDateTime']),
      status: BidStatus.values
          .firstWhere((s) => s.toString().contains(json['status'])),
      contactName: json['contactName'],
      bidItems: json['details']);

  String orderId;
  final DateTime createdDate;
  final String sellerId;
  final String amount;
  final DateTime pickupDate;
  final BidStatus status;
  final String contactName;
  final Map<String, dynamic> bidItems;
}

enum BidStatus { cancelled, pending, successful }
