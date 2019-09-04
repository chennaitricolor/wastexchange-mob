// To parse this JSON data, do
//
//     final sellerItemDetails = sellerItemDetailsFromJson(jsonString);

import 'dart:convert';
import 'package:wastexchange_mobile/models/item.dart';

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
    // TODO(Sayeed): See if you can move the api response parsing to user_client.
    final List<Item> itemsList = [];
    detailsJson.forEach((k, v) => itemsList.add(itemFromJson(k, v)));
    itemsList.sort((i1, i2) => i1.displayName.compareTo(i2.displayName));
    return itemsList.where((item) => item.qty > 0).toList();
  }

  int sellerId;
  int id;
  List<Item> items;

  Map<String, dynamic> toJson() => {
        'sellerId': sellerId,
        'id': id,
      };
}
