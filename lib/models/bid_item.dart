import 'package:wastexchange_mobile/models/item.dart';

class BidItem {
  BidItem({this.item, this.bidQuantity = 0, this.bidCost = 0});

  Item item;
  double bidQuantity = 0;
  double bidCost = 0;

  static List<BidItem> bidItemsForItems(List<Item> items) {
    return items.map((item) => BidItem(item: item)).toList();
  }

  Map<String, dynamic> toJson() => {
        'name': item.name,
        'quantity': item.qty,
        'price': item.price,
        'bidQuantity': bidQuantity,
        'bidCost': bidCost
      };
}
