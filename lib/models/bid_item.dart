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
    final List<BidItem> bidITemsList = [];
    BidItem bidItem;
    for (int i = 0; i < items.length; i++) {
      bidItem = mapItemToBidItem(items.elementAt(i));
      bidITemsList.add(bidItem);
    }
    return bidITemsList;
  }

  @override
  // TODO(Surya): implement hashCode
  int get hashCode => super.hashCode;
}
