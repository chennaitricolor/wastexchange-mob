import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/resources/api_base_helper.dart';

class BidClient {
  BidClient([ApiBaseHelper helper]) {
    _helper = helper ?? ApiBaseHelper();
  }

  static const PATH_MY_BIDS = '/bids';

  ApiBaseHelper _helper;

  Future<List<Bid>> getMyBids() async {
    final response = await _helper.get(true, PATH_MY_BIDS);
    return bidsFromJson(response);
  }
}
