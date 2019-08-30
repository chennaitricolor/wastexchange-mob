import 'package:wastexchange_mobile/models/item.dart';

class BidItem {
  BidItem({this.item, this.bidQuantity, this.bidCost});

  Item item;
  double bidQuantity;
  double bidCost;

  static List<BidItem> mapItemListToBidItemList(List<Item> items) {
    return items.map((item) => BidItem(item: item));
  }

  Map<String, dynamic> toJson() => {
        'name': item.name,
        'quantity': item.qty,
        'price': item.price,
        'bidQuantity': bidQuantity,
        'bidCost': bidCost
      };
}
