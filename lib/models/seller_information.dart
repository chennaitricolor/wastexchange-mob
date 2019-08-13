import 'item.dart';
import 'user.dart';

class SellerInformation {
 
  SellerInformation({
    this.seller,
    this.sellerItems
  });

  User seller;
  List<Item> sellerItems;
}