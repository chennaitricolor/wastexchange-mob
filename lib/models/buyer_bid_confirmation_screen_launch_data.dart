import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/user.dart';

class BuyerBidConfirmationScreenLaunchData {
  BuyerBidConfirmationScreenLaunchData(
      {this.seller,
      this.bidItems,
      this.restoreSavedState,
      this.onBackPressed}) {
    ArgumentError.checkNotNull(seller);
    ArgumentError.checkNotNull(bidItems);
    ArgumentError.checkNotNull(restoreSavedState);
    ArgumentError.checkNotNull(onBackPressed);
    if (bidItems.isEmpty) {
      throw Exception('BidItems cannot be empty');
    }
  }
  final User seller;
  final List<BidItem> bidItems;
  final VoidCallback onBackPressed;
  final bool restoreSavedState;
}
