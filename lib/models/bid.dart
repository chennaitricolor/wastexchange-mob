import 'dart:convert';

import 'package:wastexchange_mobile/models/item.dart';

List<Bid> bidsFromJson(String str) =>
    List<Bid>.from(json.decode(str).map((x) => null));

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
      orderId: json['id'],
      createdDate: json['created_at'],
      sellerId: json['seller_id'],
      amount: json['total_bid'],
      pickupDate: json['p_date_time'],
      status: json['status'],
      contactName: json['contact_name'],
      bidItems: json['details'].map((k, v) => itemFromJson(k, v)));

  String orderId;
  final DateTime createdDate;
  final String sellerId;
  final double amount;
  final DateTime pickupDate;
  final BidStatus status;
  final String contactName;
  final List<Item> bidItems;
}

enum BidStatus { cancelled, pending, successful }
