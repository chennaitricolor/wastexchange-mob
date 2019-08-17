// To parse this JSON data, do
//
//     final sellerItemDetails = sellerItemDetailsFromJson(jsonString);

import 'dart:convert';
import './item.dart';

SellerItemDetails sellerItemDetailsFromJson(String str) =>
    SellerItemDetails.fromJson(json.decode(str));

String sellerItemDetailsToJson(SellerItemDetails data) =>
    json.encode(data.toJson());

class SellerItemDetails {
  SellerItemDetails({this.sellerId, this.id, this.items});

  SellerItemDetails.fromJson(Map<String, dynamic> json) {
    SellerItemDetails(
        sellerId: json['sellerId'],
        id: json['id'],
        items: mapDetailsJsonToList(json['details']));
  }

  int sellerId;
  int id;
  List<Item> items;

  List<Item> mapDetailsJsonToList(dynamic detailsJson) {
    final List<Item> itemsList = [];
    detailsJson.forEach((k, v) => itemsList.add(itemFromJson(k, v)));
    return itemsList;
  }

  Map<String, dynamic> toJson() => {
        'sellerId': sellerId,
        'id': id,
      };
}
