import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/resources/bid_client.dart';

class BidRepository {
  BidRepository({BidClient client}) {
    _client = client ?? BidClient();
  }

  BidClient _client;

  Future<List<Bid>> getMyBids() async {
    return await _client.getMyBids();
  }

  Future<dynamic> placeBid(BuyerBidData data) async {
    return await _client.placeBid('10', data);
  }
}
