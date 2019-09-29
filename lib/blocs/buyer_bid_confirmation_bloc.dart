import 'dart:async';

import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class BuyerBidConfirmationBloc {
  BuyerBidConfirmationBloc({this.items, this.sellerId}) {
    if (isNull(items) || items.isEmpty) {
      throw Exception('BidItems cannot be null or empty');
    }
    if (isNull(sellerId)) {
      throw Exception('SellerId cannot be null');
    }
  }
  final List<BidItem> items;
  final int sellerId;

  final BidRepository _bidRepository = BidRepository();
  final StreamController _buyerController = StreamController<Result<String>>();

  StreamSink<Result<String>> get bidSink => _buyerController.sink;
  Stream<Result<String>> get bidStream => _buyerController.stream;

  double bidTotal() =>
      items.fold(0.0, (acc, item) => acc + item.bidQuantity * item.bidCost);

  Future<void> placeBid(PickupInfoData data) async {
    assert(isNotNull(data.pickupDate));
    assert(isNotNull(data.contactName));
    assert(data.contactName.isNotEmpty);
    final BuyerBidData bidData = BuyerBidData(
        bidItems: items,
        sellerId: sellerId,
        totalBid: bidTotal(),
        pDateTime: data.pickupDate,
        contactName: data.contactName,
        status: 'pending');
    bidSink.add(Result.loading('Loading'));
    final Result<String> response = await _bidRepository.placeBid(bidData);
    bidSink.add(response);
  }

  void dispose() {
    _buyerController.close();
  }
}
