import 'package:flutter/cupertino.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class SellerItemBloc {
  SellerItemBloc(SellerItemListener listener, List<Item> items){
    _listener = listener;
    _items = items ?? [];
    _validationMap = {};
  }

  final logger = AppLogger.get('SellerItemBloc');

  List<Item> _items;
  Map<int, List<int>> _validationMap;

  static const EMPTY = 0;
  static const ERROR = 1;
  static const SUCCESS = 2;

  SellerItemListener _listener;

  void onSubmitBids(List<String> quantityValues, List<String> priceValues) {
    _validationMap.clear();
    final List<BidItem> _bidItems = [];
    for(int index = 0; index < _items.length; index ++) {
      final quantityValue = isListNullOrEmpty(quantityValues) ? null : quantityValues[index];
      final priceValue = isListNullOrEmpty(priceValues) ? null : priceValues[index];
      final item = _items[index];

      if(isEmptyScenario(quantityValue, priceValue)) {
        _updateValueMap(EMPTY, index);
        continue;
      }

      if(isErrorScenario(quantityValue, priceValue)) {
        _updateValueMap(ERROR, index);
        continue;
      }

      _updateValueMap(SUCCESS, index);
      _bidItems.add(BidItem(item: item, bidCost: double.parse(priceValue), bidQuantity: double.parse(quantityValue)));
    }

    if (_validationMap.containsKey(ERROR)) {
      logger.d('Validation error');
      if (_listener != null) {
        _listener.onValidationError('It is mandatory to provide both quantity and price');
      }
      return;
    }

    if (_validationMap.containsKey(SUCCESS)) {
      logger.d('Validation success');
      if (_listener != null) {
        _listener.goToBidConfirmationPage(_bidItems);
      }
      return;
    }
    _listener.onValidationEmpty('Please fill all the values');
  }

  bool isEmptyScenario(String quantityValue, String priceValue) => isNullOrEmpty(quantityValue) && isNullOrEmpty(priceValue);

  bool isErrorScenario(String quantityValue, String priceValue) => isNullOrEmpty(quantityValue) || isNullOrEmpty(priceValue) || isZero(quantityValue) || isZero(priceValue) || !isDouble(quantityValue) || !isDouble(priceValue);

  void _updateValueMap(int key, int index) {
    if(_validationMap.containsKey(key)) {
      final valuesList = _validationMap[key];
      valuesList.add(index);
      _validationMap[key] = valuesList;
    } else {
      _validationMap[key] = [index];
    }
  }
}
