import 'item.dart';

class BidItem {
    BidItem({this.name,this.availableQuantity,this.specifiedPRice});

    String name;
    
    double availableQuantity;
    double specifiedPRice;
    double bidQuantity;
    double bidPrice;

  static BidItem mapItemToBidItem(Item item){
    BidItem bidItem;
    bidItem.name = item.name;
    bidItem.availableQuantity = item.qty;
    bidItem.specifiedPRice = item.price;
    return bidItem;
  }

  static List<BidItem> mapItemListToBidItemList(List<Item> items){
    List<BidItem> bidITemsList;
    items.map((item) => bidITemsList.add(mapItemToBidItem(item)));
    return bidITemsList;
  }

}
