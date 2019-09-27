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
  static const QUANTITY_ERROR = 1;
  static const ABOVEMAXQTY = 2;
  static const SUCCESS = 3;
  static const PRICE_ERROR = 4;

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

      if (isQuantityErrorScenario(quantityValue, index)) {
        _updateValueMap(QUANTITY_ERROR, index);
        continue;
      }

      if (isPriceErrorScenario(priceValue, index)) {
        _updateValueMap(PRICE_ERROR, index);
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
      _listener.onValidationEmpty('Please bid for at least one item', empty);
      return;
    }

    //TODO: [Chandru] Need to optimize the quantity and price error methods. It loooks like codes are duplicated.
    final List<int> quantityErrors = _validationMap[QUANTITY_ERROR];
    if (!isListNullOrEmpty(quantityErrors)) {
      final String invalidItems =
      quantityErrors.map((index) => _sellerInfo.items[index].displayName).join(', ');
      _listener.onQuantityValidationError('Please enter valid quantity values for $invalidItems', quantityErrors);
      return;
    }

    final List<int> priceErrors = _validationMap[PRICE_ERROR];
    if (!isListNullOrEmpty(priceErrors)) {
      final String invalidItems =
      priceErrors.map((index) => _sellerInfo.items[index].displayName).join(', ');
      _listener.onPriceValidationError('Please enter valid price values for $invalidItems', priceErrors);
      return;
    }

    final List<int> aboveMaxQtys = _validationMap[ABOVEMAXQTY];
    if (!isListNullOrEmpty(aboveMaxQtys)) {
      final String aboveMaxQtyItems = aboveMaxQtys
          .map((index) => _sellerInfo.items[index].displayName)
          .join(', ');
      _listener
          .onQuantityValidationError('Entered quantity is above the available quantity for $aboveMaxQtyItems', aboveMaxQtys);
      return;
    }

    _listener.onValidationSuccess(
        sellerInfo: {'seller': _sellerInfo.seller, 'bidItems': _bidItems});
  }

  bool isEmptyScenario(String quantityValue, String priceValue) =>
      quantityValue.isEmpty && priceValue.isEmpty;

  bool isQuantityErrorScenario(String quantityValue, int index) {
    if (_validationMap[EMPTY].contains(index)) {
      throw Exception('Both Quantity and Price are empty');
    }
    if (quantityValue.isEmpty || quantityValue == '0' || !isDouble(quantityValue)) {
      return true;
    }
    return !isPositive(quantityValue);
  }

  bool isPriceErrorScenario(String priceValue, int index) {
    if (_validationMap[QUANTITY_ERROR].contains(index)) {
      throw Exception('Both Quantity and Price are empty');
    }
    if (priceValue.isEmpty || priceValue == '0' || !isDouble(priceValue)) {
      return true;
    }
    return !isPositive(priceValue);
  }

  bool isAboveMaxQty(String quantityValue, int index) {
    if (_validationMap[QUANTITY_ERROR].contains(index) ||
        _validationMap[PRICE_ERROR].contains(index)) {
      throw Exception(
          'Empty or Error case should not happen here because of order of code execution');
    }
    return double.parse(quantityValue) > _sellerInfo.items[index].qty;
  }

  void _resetValueMap() {
    _validationMap.clear();
    _validationMap[QUANTITY_ERROR] = [];
    _validationMap[PRICE_ERROR] = [];
    _validationMap[EMPTY] = [];
    _validationMap[ABOVEMAXQTY] = [];
    _validationMap[SUCCESS] = [];
  }

  void _updateValueMap(int key, int index) {
    _validationMap[key].add(index);
  }
}
