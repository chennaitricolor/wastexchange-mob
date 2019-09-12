import 'dart:collection';

import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';

class SellerBidData {

  SellerBidData({this.sellerInfo, this.bid}){
    ArgumentError.checkNotNull(sellerInfo);
    mapSellerAndBidItems();
  }

  SellerInfo sellerInfo;
  Bid bid;

  Map<Item, dynamic> sellerItemBidMap = HashMap();

  void mapSellerAndBidItems() {
    for(Item item in sellerInfo.items) {
      if(bid != null && bid.bidItems != null) {
        var bidData = bid.bidItems[item.displayName];
        sellerItemBidMap[item] = bidData;
      }
    }
  }
}