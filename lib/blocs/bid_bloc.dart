import 'dart:async';

import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class BidBloc {
  BidBloc({this.items, this.sellerId}) {
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

  Future<void> placeBid({DateTime pickupDate, String contactName}) async {
    assert(isNotNull(pickupDate));
    assert(isNotNull(contactName));
    assert(contactName.isNotEmpty);
    final BuyerBidData data = BuyerBidData(
        bidItems: items,
        sellerId: sellerId,
        totalBid: bidTotal(),
        pDateTime: pickupDate,
        contactName: contactName,
        status: 'pending');
    bidSink.add(Result.loading('Loading'));
    final Result<String> response = await _bidRepository.placeBid(data);
    bidSink.add(response);
  }

  void dispose() {
    _buyerController.close();
  }
}
