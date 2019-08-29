import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';

class BidBloc {
  final BidRepository _bidRepository = BidRepository();
  final StreamController _buyerController = StreamController<dynamic>();

  StreamSink<dynamic> get bidSink => _buyerController.sink;
  Stream<dynamic> get bidStream => _buyerController.stream;

  Future<void> placeBid(BuyerBidData data) async {
    // bidSink.add(ApiResponse.loading(Constants.LOADING_BUYER_BID));
    try {
      final dynamic response = await _bidRepository.placeBid(data);
      debugPrint(response);
      // bidSink.add(ApiResponse.completed(response));
    } catch (e) {
      // bidSink.add(ApiResponse.error(e.toString()));
    }
  }

  void dispose() {
    _buyerController.close();
  }
}
