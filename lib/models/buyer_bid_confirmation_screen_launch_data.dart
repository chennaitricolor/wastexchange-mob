import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/user.dart';

class BuyerBidConfirmationScreenLaunchData {
  BuyerBidConfirmationScreenLaunchData(
      {@required this.seller,
      @required this.bidItems,
      @required this.restoreSavedState,
      @required this.onBackPressed}) {
    ArgumentError.checkNotNull(seller);
    ArgumentError.checkNotNull(bidItems);
    ArgumentError.checkNotNull(restoreSavedState);
    ArgumentError.checkNotNull(onBackPressed);
  }
  final User seller;
  final List<BidItem> bidItems;
  final VoidCallback onBackPressed;
  final bool restoreSavedState;
}
