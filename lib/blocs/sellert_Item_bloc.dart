
import 'package:flutter/cupertino.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class SellerItemBloc {

  final logger = AppLogger.get('SellerItemBloc');

  List<TextEditingController> _quantityTextEditingControllers = [];
  List<TextEditingController> _priceTextEditingControllers = [];
  final List<BidItem> _bidItems = [];
  Map<int, List<int>> _validationMap = {};
  List<Item> _items;

  static const EMPTY = 0;
  static const ERROR = 1;
  static const SUCCESS = 2;

  SellerItemListener _listener;


  SellerItemBloc(SellerItemListener listener, List<Item> items){
    _items = items ?? [];
    _listener = listener;
    _quantityTextEditingControllers = items != null ? items.map((_) => TextEditingController()).toList() : null;
    _priceTextEditingControllers = items != null ? items.map((_) => TextEditingController()).toList() : null;
  }

  void onSubmitBids() {
    _validationMap.clear();
    _bidItems.clear();
    for(int index = 0; index < items.length; index ++) {
      final quantityValue = _quantityTextEditingControllers[index].text;
      final priceValue = _priceTextEditingControllers[index].text;
      final item = items[index];

      if((isNullOrEmpty(quantityValue) || isZero(quantityValue))
          && (isNullOrEmpty(priceValue) || isZero(priceValue))) {
        updateValueMap(EMPTY, index);
        continue;
      }

      if((isNullOrEmpty(quantityValue)) || (isNullOrEmpty(priceValue) || !isDouble(quantityValue) || !isDouble(priceValue))) {
        updateValueMap(ERROR, index);
        continue;
      }

      updateValueMap(SUCCESS, index);
      _bidItems.add(BidItem(item: item, bidCost: double.parse(priceValue), bidQuantity: double.parse(quantityValue)));
    }

    if(_validationMap.containsKey(ERROR)) {
      logger.d('Validation error');
      if (_listener != null) {
        _listener.onValidationError('Both the fields should not be empty');
      }
      return;
    }

    if(_validationMap.containsKey(SUCCESS)) {
      logger.d('Validation success');
      if (_listener != null) {
        _listener.goToBidConfirmationPage(_bidItems);
      }
      return;
    }
    _listener.onValidationError('Please fill all the values');
  }

  void updateValueMap(int key, int index) {
    if(_validationMap.containsKey(key)) {
      final valuesList = _validationMap[key];
      valuesList.add(index);
      _validationMap[key] = valuesList;
    } else {
      _validationMap[key] = [index];
    }
  }

  List<Item> get items => _items;

  TextEditingController quantityTextEditingController(int position) => isListNullOrEmpty(_quantityTextEditingControllers) || isInValidIndex(_quantityTextEditingControllers.length, position) ? null : _quantityTextEditingControllers[position];
  TextEditingController priceTextEditingController(int position) => isListNullOrEmpty(_priceTextEditingControllers) || isInValidIndex(_priceTextEditingControllers.length, position) ? null : _priceTextEditingControllers[position];
}
