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

  static SellerItemDetails fromJson(String str) {
    final Map<String, dynamic> sellerDetailsJson = json.decode(str);
    final sellerItems = mapDetailsJsonToList(sellerDetailsJson['details']);
    return SellerItemDetails(
        sellerId: sellerDetailsJson['sellerId'],
        id: sellerDetailsJson['id'],
        items: sellerItems);
  }

  static List<Item> mapDetailsJsonToList(dynamic detailsJson) {
    final List<Item> itemsList = [];
    detailsJson.forEach((k, v) => itemsList.add(itemFromJson(k, v)));
    return itemsList;
  }

  int sellerId;
  int id;
  List<Item> items;

  Map<String, dynamic> toJson() => {
        'sellerId': sellerId,
        'id': id,
      };
}
