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

  Future<Result<String>> placeBid(BuyerBidData data, int bidId) async {
    final thisUser = await _userRepository.getProfile();
    return await _client.placeBid(buyerId: thisUser.id, data: data, bidId: bidId);
  }

  Future<Result<List<Bid>>> getMyBids() async {
    final thisUser = await _userRepository.getProfile();
    return _client.getBids(userId: thisUser.id);
  }
}
