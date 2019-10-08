import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/user.dart';

class BuyerBidConfirmationScreenLaunchData {
  BuyerBidConfirmationScreenLaunchData(
      {this.seller, this.bidItems, this.pickupInfoData, this.onBackPressed}) {
    ArgumentError.checkNotNull(seller);
    ArgumentError.checkNotNull(bidItems);
    if (bidItems.isEmpty) {
      throw Exception('BidItems cannot be empty');
    }
  }
  final User seller;
  final List<BidItem> bidItems;
  final VoidCallback onBackPressed;
  final PickupInfoData pickupInfoData;
}
