import 'dart:async';

import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/models/result.dart';

class SellerItemDetailsBloc {
  final logger = AppLogger.get('SellerMapsBloc');
  final _userRepository = UserRepository();
  final StreamController _sellerItemDetailsController =
      StreamController<Result<SellerItemDetails>>();

  StreamSink<Result<SellerItemDetails>> get _sellerItemDetailsSink =>
      _sellerItemDetailsController.sink;
  Stream<Result<SellerItemDetails>> get sellerItemDetailsStream =>
      _sellerItemDetailsController.stream;

  Future<void> getSellerDetails(int id) async {
    try {
      final response = await _userRepository.getSellerDetails(id);
      _sellerItemDetailsSink.add(Result.completed(response));
    } catch (e) {
      _sellerItemDetailsSink.add(Result.error(e.toString()));
      logger.e(e.toString());
    }
  }

  void dispose() {
    _sellerItemDetailsController.close();
  }
}
