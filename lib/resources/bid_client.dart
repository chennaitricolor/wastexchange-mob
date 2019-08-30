import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class BidClient {
  BidClient([ApiBaseHelper helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const PATH_MY_BIDS = '/bids';
  static const PATH_PLACE_BID = '/buyer/:buyerId/bids';

  ApiBaseHelper _helper;

  Future<List<Bid>> getMyBids() async {
    final response = await _helper.get(true, PATH_MY_BIDS);
    return bidsFromJson(response);
  }

  Future<void> placeBid(String userId, BuyerBidData data) async {
    final response = await _helper.post(
        true,
        PATH_PLACE_BID.replaceFirst(':buyerId', userId),
        _placeBidPostData(data));
    return bidsFromJson(response);
  }

  dynamic _placeBidPostData(BuyerBidData data) {
    final Map<String, dynamic> details = {};
    data.bidItems.forEach((item) => details[item.item.name] = {
          'bidCost': item.bidCost,
          'bidQuantity': item.bidQuantity
        });

    return {
      'details': details,
      'sellerId': 1497,
      'buyerId': 2,
      'totalBid': data.totalBid,
      'pDateTime': data.pDateTime.toUtc().toString(),
      'contactName': data.contactName,
      'status': data.status,
    };
  }
}
