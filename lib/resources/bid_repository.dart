import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/bid_client.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';

class BidRepository {
  BidRepository({BidClient client, UserRepository userRepository}) {
    _client = client ?? BidClient();
    _userRepository = userRepository ?? UserRepository();
  }

  BidClient _client;
  UserRepository _userRepository;

  Future<List<Bid>> getMyBids() async {
    return await _client.getMyBids();
  }

  Future<Result<String>> placeBid(BuyerBidData data) async {
    final userId = await _userRepository.getProfileId();
    return await _client.placeBid(userId, data);
  }
}
