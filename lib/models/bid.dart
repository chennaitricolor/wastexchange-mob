import 'dart:collection';
import 'package:wastexchange_mobile/models/item.dart';

class Bid {
  Bid(
      {this.orderId,
      this.createdDate,
      this.sellerId,
      this.amount,
      this.pickupDate,
      this.status,
      this.contactName,
      this.nameToItemMap}) {
    ArgumentError.checkNotNull(orderId);
    ArgumentError.checkNotNull(createdDate);
    ArgumentError.checkNotNull(sellerId);
    ArgumentError.checkNotNull(amount);
    ArgumentError.checkNotNull(pickupDate);
    ArgumentError.checkNotNull(status);
    ArgumentError.checkNotNull(contactName);
    ArgumentError.checkNotNull(nameToItemMap);
  }

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
      orderId: json['id'],
      createdDate: DateTime.parse(json['createdAt']),
      sellerId: json['sellerId'],
      amount: json['totalBid'],
      pickupDate: DateTime.parse(json['pDateTime']),
      status: BidStatus.values
          .firstWhere((s) => s.toString().contains(json['status'])),
      contactName: json['contactName'],
      nameToItemMap: getNameToItemMap(json['details']));

  final int orderId;
  final DateTime createdDate;
  final int sellerId;
  final double amount;
  final DateTime pickupDate;
  BidStatus status;
  final String contactName;
  final Map<String, Item> nameToItemMap;

  static Map<String, Item> getNameToItemMap(Map<String, dynamic> map) {
    final Map<String, Item> bitItemLites = HashMap();
    map.forEach((name, value) {
      bitItemLites[name] = Item.fromBidJson(value, name);
    });

    return bitItemLites;
  }
}

enum BidStatus { cancelled, pending, successful }
