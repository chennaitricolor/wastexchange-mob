// To parse this JSON data, do
//
//     final sellerItemDetails = sellerItemDetailsFromJson(jsonString);

import 'dart:convert';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

SellerItemDetails sellerItemDetailsFromJson(String str) =>
    SellerItemDetails.fromJson(json.decode(str));

String sellerItemDetailsToJson(SellerItemDetails data) =>
    json.encode(data.toJson());

class SellerItemDetails {
  SellerItemDetails({this.sellerId, this.id, this.items}) {
    ArgumentError.checkNotNull(
        sellerId, 'sellerId is missing in SellerItemDetails');
    ArgumentError.checkNotNull(id, 'id is missing in SellerItemDetails');
  }

  static SellerItemDetails fromJson(Map<String, dynamic> sellerDetailsJson) {
    final sellerItems = mapDetailsJsonToList(sellerDetailsJson['details']);
    return SellerItemDetails(
        sellerId: sellerDetailsJson['sellerId'],
        id: sellerDetailsJson['id'],
        items: sellerItems);
  }

  // TODO(Sayeed): Where should parsing logic reside
  static List<Item> mapDetailsJsonToList(dynamic detailsJson) {
    if (isNull(detailsJson)) {
      return [];
    }
    final List<Item> itemsList = [];
    detailsJson.forEach((itemName, json) {
      if (isValidItem(json)) {
        itemsList.add(Item.fromJson(itemName, json));
      }
    });
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
