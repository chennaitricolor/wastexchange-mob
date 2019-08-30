import 'item.dart';

class BidItem extends Item{

  BidItem(name,quantity,price) : super(name:name,qty:quantity,price:price);

  double bidQuantity;
  double bidPrice;

  static BidItem mapItemToBidItem(Item item) {
    final BidItem bidItem = BidItem(
        item.name,
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
