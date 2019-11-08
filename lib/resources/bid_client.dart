import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';
import 'package:wastexchange_mobile/resources/json_parsing.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/models/api_exception.dart';

class BidClient {
  BidClient([ApiBaseHelper helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const pathMyBids = '/bids';
  static const pathUpdateBid = '/bids/:bidId';
  static const pathPlaceBid = '/buyer/:buyerId/bids';

  ApiBaseHelper _helper;

  Future<Result<String>> placeBid({int buyerId, BuyerBidData data}) async {
    try {
      await _helper.post(
          true,
          pathPlaceBid.replaceFirst(':buyerId', buyerId.toString()),
          _placeBidPostData(buyerId, data));
      return Result.completed('');
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.BID_CREATE_FAILED);
    }
  }

  Future<Result<String>> updateBid(
      {int orderId, int buyerId, BuyerBidData data}) async {
    try {
      await _helper.put(
          true,
          pathUpdateBid.replaceFirst(':bidId', orderId.toString()),
          _placeBidPostData(buyerId, data));
      return Result.completed('');
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.BID_EDIT_FAILED);
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
      'pDateTime': data.pDateTime.toString(),
      'contactName': data.contactName,
      'status': data.status,
    };
  }

  Future<Result<List<Bid>>> getBids({int userId}) async {
    try {
      final response = await _helper
          .get(pathPlaceBid.replaceFirst(':buyerId', userId.toString()));
      final bids = List<Bid>.from(codecForIntToDoubleConversion(key: 'totalBid')
          .decode(response)
          .map((x) => Bid.fromJson(x)));
      return Result.completed(bids);
    } on ApiException catch (e) {
      return Result.error(e.message);
    } catch (e) {
      // TODO(Sayeed): Need to move this to a higher layer close to the UI possibly bloc
      return Result.error(Constants.BIDS_FETCH_FAILED);
    }
  }
}
