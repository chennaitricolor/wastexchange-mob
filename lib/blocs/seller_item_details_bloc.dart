import 'dart:async';

import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class SellerItemDetailsBloc {
  final _userRepository = UserRepository();
  final StreamController _sellerItemDetailsController =
      StreamController<Result<SellerItemDetails>>();

  StreamSink<Result<SellerItemDetails>> get _sellerItemDetailsSink =>
      _sellerItemDetailsController.sink;
  Stream<Result<SellerItemDetails>> get sellerItemDetailsStream =>
      _sellerItemDetailsController.stream;

  Future<void> getSellerDetails(int sellerId) async {
    _sellerItemDetailsSink.add(Result.loading(Constants.LOADING));
    final Result<SellerItemDetails> response =
        await _userRepository.getSellerDetails(sellerId);
    _sellerItemDetailsSink.add(response);
  }

  void dispose() {
    _sellerItemDetailsController.close();
  }
}
