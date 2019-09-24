import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class SellerItemBloc {
  SellerItemBloc(SellerItemListener listener, SellerInfo sellerInfo) {
    ArgumentError.checkNotNull(listener);
    if (sellerInfo.items.isEmpty) {
      throw Exception('Seller Items is empty');
    }
    _sellerInfo = sellerInfo;
    _listener = listener;
    _validationMap = {};
  }

  final logger = AppLogger.get('SellerItemBloc');

  SellerInfo _sellerInfo;
  Map<int, List<int>> _validationMap;

  static const EMPTY = 0;
  static const ERROR = 1;
  static const ABOVEMAXQTY = 2;
  static const SUCCESS = 3;

  SellerItemListener _listener;

  void onSubmitBids(List<String> quantityValues, List<String> priceValues) {
    _resetValueMap();
    final List<BidItem> _bidItems = [];

    for (int index = 0; index < _sellerInfo.items.length; index++) {
      final quantityValue = quantityValues[index];
      final priceValue = priceValues[index];
      final item = _sellerInfo.items[index];

      if (isEmptyScenario(quantityValue, priceValue)) {
        _updateValueMap(EMPTY, index);
        continue;
      }

      if (isErrorScenario(quantityValue, priceValue, index)) {
        _updateValueMap(ERROR, index);
        continue;
      }

      if (isAboveMaxQty(quantityValue, index)) {
        _updateValueMap(ABOVEMAXQTY, index);
        continue;
      }

      _updateValueMap(SUCCESS, index);

      _bidItems.add(BidItem(
          item: item,
          bidCost: double.parse(priceValue),
          bidQuantity: double.parse(quantityValue)));
    }

    final List<int> empty = _validationMap[EMPTY];

    if (empty?.length == _sellerInfo.items.length) {
      _listener.onValidationEmpty('Please bid for at least one item');
      return;
    }

    final List<int> error = _validationMap[ERROR];

    if (!isListNullOrEmpty(error)) {
      final String invalidItems =
          error.map((index) => _sellerInfo.items[index].displayName).join(', ');
      _listener.onValidationError('Invalid values for $invalidItems');
      return;
    }

    final List<int> aboveMaxQty = _validationMap[ABOVEMAXQTY];

    if (!isListNullOrEmpty(aboveMaxQty)) {
      final String aboveMaxQtyItems = aboveMaxQty
          .map((index) => _sellerInfo.items[index].displayName)
          .join(', ');
      _listener
          .onValidationError('qty above available qty for $aboveMaxQtyItems');
      return;
    }

    _listener.onValidationSuccess(
        sellerInfo: {'seller': _sellerInfo.seller, 'bidItems': _bidItems});
  }

  bool isEmptyScenario(String quantityValue, String priceValue) =>
      quantityValue.isEmpty && priceValue.isEmpty;

  bool isErrorScenario(String quantityValue, String priceValue, int index) {
    if (_validationMap[EMPTY].contains(index)) {
      throw Exception('Both Quantity and Price are empty');
    }

    final bool isOneOfTwoEmpty =
        quantityValue.isEmpty && priceValue.isNotEmpty ||
            quantityValue.isNotEmpty && priceValue.isEmpty;
    final bool isOneOrTwoZero = quantityValue == '0' || priceValue == '0';
    final bool isOneOrTwoNotDouble =
        !isDouble(quantityValue) || !isDouble(priceValue);

    if (isOneOfTwoEmpty || isOneOrTwoZero || isOneOrTwoNotDouble) {
      return true;
    }

    final bool isOneOrTwoNegative =
        !isPositive(quantityValue) || !isPositive(priceValue);
    return isOneOrTwoNegative;
  }

  bool isAboveMaxQty(String quantityValue, int index) {
    if (_validationMap[EMPTY].contains(index) ||
        _validationMap[ERROR].contains(index)) {
      throw Exception(
          'Empty or Error case should not happen here because of order of code execution');
    }
    return double.parse(quantityValue) > _sellerInfo.items[index].qty;
  }

  void _resetValueMap() {
    _validationMap.clear();
    _validationMap[ERROR] = [];
    _validationMap[EMPTY] = [];
    _validationMap[ABOVEMAXQTY] = [];
    _validationMap[SUCCESS] = [];
  }

  void _updateValueMap(int key, int index) {
    _validationMap[key].add(index);
  }
}
