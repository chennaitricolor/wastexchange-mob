import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class BidClient {
  BidClient([ApiBaseHelper helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const PATH_MY_BIDS = '/bids';
  static const PATH_PLACE_BID = '/buyer/:buyerId/bids';

  ApiBaseHelper _helper;

  // TODO(Sayeed): Change the return type
  Future<Result<String>> placeBid({int buyerId, BuyerBidData data}) async {
    try {
      await _helper.post(
          true,
          PATH_PLACE_BID.replaceFirst(':buyerId', buyerId.toString()),
          _placeBidPostData(buyerId, data));
      return Result.completed('');
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  dynamic _placeBidPostData(int userId, BuyerBidData data) {
    final Map<String, dynamic> details = Map.fromIterable(data.bidItems,
        key: (item) => item.item.name,
        value: (item) =>
            {'bidCost': item.bidCost, 'bidQuantity': item.bidQuantity});
    return {
      'details': details,
      'sellerId': data.sellerId,
      'buyerId': userId,
      'totalBid': data.totalBid,
      'pDateTime': data.pDateTime.toUtc().toString(),
      'contactName': data.contactName,
      'status': data.status,
    };
  }

  Future<Result<List<Bid>>> getBids({int userId}) async {
    try {
      final result = await _helper
          .get(PATH_PLACE_BID.replaceFirst(':buyerId', userId.toString()));
      return Result.completed(bidsFromJson(result));
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
