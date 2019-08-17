import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/resources/bid_client.dart';

class BidRepository {
  BidRepository({BidClient client}) {
    _client = client ?? BidClient();
  }

  BidClient _client;

  Future<List<Bid>> getMyBids() async {
    return await _client.getMyBids();
  }
}
