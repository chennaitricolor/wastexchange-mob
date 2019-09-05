import 'dart:async';

import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/models/result.dart';

class MyBidsBloc {
  final logger = AppLogger.get('OtpBloc');
  final BidRepository _bidRepository = BidRepository();
  final StreamController _myBidsController =
      StreamController<Result<List<Bid>>>();

  StreamSink<Result<List<Bid>>> get _myBidsSink => _myBidsController.sink;
  Stream<Result<List<Bid>>> get myBidsStream => _myBidsController.stream;

  Future<void> getMyBids() async {
    _myBidsSink.add(Result.loading(Constants.LOADING_OTP));
    try {
      final List<Bid> response = await _bidRepository.getMyBids();
      _myBidsSink.add(Result.completed(response));
    } catch (e) {
      _myBidsSink.add(Result.error(e.toString()));
      logger.e(e.toString());
    }
  }

  void dispose() {
    _myBidsController.close();
  }
}
