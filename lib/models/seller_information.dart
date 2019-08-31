import 'item.dart';
import 'user.dart';

class SellerItem {
 
  SellerItem({
    this.seller,
    this.sellerItems
  });

  User seller;
  List<Item> sellerItems;
}