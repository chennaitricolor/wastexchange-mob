import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/core/utils/global_utils.dart';

class BuyerBidConfirmationScreenLaunchData {
  BuyerBidConfirmationScreenLaunchData({
    @required this.seller,
    @required this.bidItems,
    @required this.isEditBid,
    this.orderId,
    this.pickupInfoData,
    this.onBackPressed,
  })  : assert(isNotNull(seller)),
        assert(isNotNull(bidItems)),
        assert(bidItems.isNotEmpty),
        assert(isNotNull(isEditBid)),
        assert(!isEditBid || isEditBid && isNotNull(orderId));

  final User seller;
  final List<BidItem> bidItems;
  final VoidCallback onBackPressed;
  final PickupInfoData pickupInfoData;
  final bool isEditBid;
  final int orderId;
}
