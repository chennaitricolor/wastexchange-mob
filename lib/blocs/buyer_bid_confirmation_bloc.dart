import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class BuyerBidConfirmationBloc {
  BuyerBidConfirmationBloc(
      {@required List<BidItem> items, @required int sellerId}) {
    ArgumentError.checkNotNull(items);
    ArgumentError.checkNotNull(sellerId);
    if (items.isEmpty) {
      throw Exception('BidItems cannot be empty');
    }
    _items = items;
    _sellerId = sellerId;
  }

// TODO(Sayeed): In some classes we are declaring variables at the bottom and in some classes at top. Do as per convention.
  List<BidItem> _items;
  int _sellerId;

  final BidRepository _bidRepository = BidRepository();
  final StreamController _buyerController = StreamController<Result<String>>();

  StreamSink<Result<String>> get bidSink => _buyerController.sink;
  Stream<Result<String>> get bidStream => _buyerController.stream;

  Future<void> placeBid(PickupInfoData data) async {
    assert(isNotNull(data.pickupDate));
    assert(isNotNull(data.contactName));
    assert(data.contactName.isNotEmpty);
    final BuyerBidData bidData = BuyerBidData(
        bidItems: _items,
        sellerId: _sellerId,
        totalBid: bidTotal,
        pDateTime: data.pickupDate,
        contactName: data.contactName,
        status: 'pending');
    bidSink.add(Result.loading('Loading'));
    final Result<String> response = await _bidRepository.placeBid(bidData);
    bidSink.add(response);
  }

  double get bidTotal {
    final total =
        _items.fold(0.0, (acc, item) => acc + item.bidQuantity * item.bidCost);
    return roundToPlaces(total, 2);
  }

  List<BidItem> get items => _items;

  void dispose() {
    _buyerController.close();
  }
}
