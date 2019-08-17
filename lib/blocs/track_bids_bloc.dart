import 'dart:async';

import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';
import 'package:wastexchange_mobile/models/api_response.dart';

class TrackBidsBloc {
  final logger = getLogger('OtpBloc');
  final BidRepository _bidRepository = BidRepository();
  final StreamController _trackBidsController =
      StreamController<ApiResponse<List<Bid>>>();

  StreamSink<ApiResponse<List<Bid>>> get _trackBidsSink =>
      _trackBidsController.sink;
  Stream<ApiResponse<List<Bid>>> get trackBidsStream =>
      _trackBidsController.stream;

  Future<void> getMyBids() async {
    _trackBidsSink.add(ApiResponse.loading(Constants.LOADING_OTP));
    try {
      final List<Bid> response = await _bidRepository.getMyBids();
      _trackBidsSink.add(ApiResponse.completed(response));
    } catch (e) {
      _trackBidsSink.add(ApiResponse.error(e.toString()));
      logger.e(e.toString());
    }
  }

  void dispose() {
    _trackBidsController.close();
  }
}
