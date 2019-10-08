import 'dart:async';

import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/models/result.dart';

class MyBidsBloc {
  MyBidsBloc(
      {BidRepository bidRepository,
      StreamController myBidsController,
      UserRepository userRepository}) {
    _bidRepository = bidRepository ?? BidRepository();
    _myBidsController =
        myBidsController ?? StreamController<Result<List<Bid>>>();
    _userRepository = userRepository ?? UserRepository();
  }
  BidRepository _bidRepository;
  UserRepository _userRepository;
  List<Bid> _bids = [];
  final Map<int, User> _sellerIdToSellerMap = {};
  final logger = AppLogger.get('MyBidsBloc');

  StreamController _myBidsController = StreamController<Result<List<Bid>>>();
  StreamSink<Result<List<Bid>>> get _myBidsSink => _myBidsController.sink;
  Stream<Result<List<Bid>>> get myBidsStream => _myBidsController.stream;

  Future<void> myBids() async {
    _myBidsSink.add(Result.loading('Loading'));
    final Result<List<Bid>> response = await _bidRepository.getMyBids();
    // TODO(Sayeed): Can we improve this. Examining the state and doing computations here feels off.
    if (response.status == Status.COMPLETED) {
      _bids = response.data;
      _bids.sort((bid1, bid2) => bid2.pickupDate.compareTo(bid1.createdDate));
      for (Bid bid in _bids) {
        final Result<User> seller =
            await _userRepository.getUser(id: bid.sellerId);
        _sellerIdToSellerMap[bid.sellerId] = seller.data;
      }
      _myBidsSink.add(Result.completed(_bids));
      return;
    }
    _myBidsSink.add(response);
  }

  int bidCount() {
    return _bids.length;
  }

  Bid bidAtIndex(int index) {
    return _bids[index];
  }

  User user({int id}) {
    return _sellerIdToSellerMap[id];
  }

  void dispose() {
    _myBidsController.close();
  }
}
