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

  Future<void> trackBid() async {
    _myBidsSink.add(Result.loading('loading'));
    final Result<List<Bid>> response = await _bidRepository.getMyBids();
    _myBidsSink.add(response);
  }

  void dispose() {
    _myBidsController.close();
  }
}
