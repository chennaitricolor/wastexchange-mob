import 'dart:async';

import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/bid_repository.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class BidDetailBloc {
  final BidRepository _bidRepository = BidRepository();
  final UserRepository _userRepository = UserRepository();

  final StreamController _bidController = StreamController<Result<String>>();
  final StreamController _sellerController =
      StreamController<Result<SellerItemDetails>>();

  StreamSink<Result<String>> get bidSink => _bidController.sink;
  Stream<Result<String>> get bidStream => _bidController.stream;

  StreamSink<Result<SellerItemDetails>> get sellerSink =>
      _sellerController.sink;
  Stream<Result<SellerItemDetails>> get sellerStream =>
      _sellerController.stream;

  Future<void> cancelBid(Bid bid, SellerItemDetails sellerItemDetails) async {
    final int bidId = bid.orderId;
    final double totalBid = bid.nameToItemMap.values
        .fold(0, (acc, item) => acc + item.qty * item.price);

    final BuyerBidData data = BuyerBidData(
        bidItems: getBidItems(bid.nameToItemMap, sellerItemDetails.items),
        sellerId: bid.sellerId,
        totalBid: totalBid,
        pDateTime: bid.pickupDate,
        contactName: bid.contactName,
        status: BidStatus.cancelled.toString().split('.').last);

    return updateBid(bidId, data);
  }

  List<BidItem> getBidItems(
      Map<String, Item> buyerItems, List<Item> sellerItems) {
    final List<BidItem> bidItems = [];
    for (final sellerItem in sellerItems) {
      final Item buyerItem = buyerItems[sellerItem.name];
      if (buyerItem != null) {
        final BidItem bidItem = BidItem(
            item: sellerItem,
            bidQuantity: buyerItem.qty,
            bidCost: buyerItem.price);
        bidItems.add(bidItem);
      }
    }

    return bidItems;
  }

  Future<void> updateBid(int bidId, BuyerBidData data) async {
    bidSink.add(Result.loading(Constants.LOADING));
    final Result<String> response = await _bidRepository.updateBid(bidId, data);
    bidSink.add(response);
  }

  Future<void> getSellerDetails(int sellerId) async {
    sellerSink.add(Result.loading(Constants.LOADING));
    final Result<SellerItemDetails> response =
        await _userRepository.getSellerDetails(sellerId);
    sellerSink.add(response);
  }

  Future<Result<User>> getUser(int userId) async {
    return _userRepository.getUser(id: userId);
  }

  void dispose() {
    _bidController.close();
    _sellerController.close();
  }

  void sortSellerItemsBasedOnBid(SellerItemDetails sellerItemDetails, Bid bid) {
    sellerItemDetails.items.sort((a, b) => _compare(bid, a, b));
  }

  int _compare(Bid bid, Item a, Item b) {
    if (bid.nameToItemMap[a.name] != null &&
        bid.nameToItemMap[b.name] == null) {
      return -1;
    } else if (bid.nameToItemMap[a.name] == null &&
        bid.nameToItemMap[b.name] != null) {
      return 1;
    }

    return 0;
  }
}
