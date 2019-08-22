import 'item.dart';

class BidItem {
  BidItem({this.name, this.availableQuantity, this.specifiedPRice});

  String name;

  int availableQuantity;
  double specifiedPRice;
  double bidQuantity;
  double bidPrice;

  static BidItem mapItemToBidItem(Item item) {
    final BidItem bidItem = BidItem(
        name: item.name,
        availableQuantity: item.qty,
        specifiedPRice: item.price);
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
