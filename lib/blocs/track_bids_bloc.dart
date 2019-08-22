import 'dart:async';

import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/logger.dart';
import 'package:wastexchange_mobile/models/result.dart';

class TrackBidsBloc {
  final logger = getLogger('OtpBloc');
  final BidRepository _bidRepository = BidRepository();
  final StreamController _trackBidsController =
      StreamController<Result<List<Bid>>>();

  StreamSink<Result<List<Bid>>> get _trackBidsSink => _trackBidsController.sink;
  Stream<Result<List<Bid>>> get trackBidsStream => _trackBidsController.stream;

  Future<void> getMyBids() async {
    _trackBidsSink.add(Result.loading(Constants.LOADING_OTP));
    try {
      final List<Bid> response = await _bidRepository.getMyBids();
      _trackBidsSink.add(Result.completed(response));
    } catch (e) {
      _trackBidsSink.add(Result.error(e.toString()));
      logger.e(e.toString());
    }
  }

  void dispose() {
    _trackBidsController.close();
  }
}
