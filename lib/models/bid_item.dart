import 'item.dart';

class BidItem extends Item{

  BidItem(name, displayName, quantity, price) : super(name : name, displayName : displayName, qty : quantity, price : price);

  double bidQuantity;
  double bidPrice;

  static BidItem mapItemToBidItem(Item item) {
    final BidItem bidItem = BidItem(
        item.name,
        item.displayName,
        item.qty,
        item.price);
    return bidItem;
  }

  static List<BidItem> mapItemListToBidItemList(List<Item> items) {
      return items.map((item) => mapItemToBidItem(item)).toList();
  }

  @override
  String toString() {
    return "$qty = $bidQuantity , $price = $bidPrice";
  }
}
