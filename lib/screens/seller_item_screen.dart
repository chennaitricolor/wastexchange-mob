import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/seller_item.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class SellerItemScreen extends StatefulWidget {
  const SellerItemScreen({this.sellerInfo});

  final SellerItem sellerInfo;

  static const routeName = '/sellerItemScreen';

  @override
  _SellerItemScreenState createState() => _SellerItemScreenState();
}

class _SellerItemScreenState extends State<SellerItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final logger = AppLogger.get('SellerInformationScreen');
  List<Item> items;
  List<TextEditingController> quantityTextEditingControllers = [];
  List<TextEditingController> priceTextEditingControllers = [];
  Map<int, List<int>> validationMap = {};
  List<BidItem> bidItems = [];

  static const EMPTY = 0;
  static const ERROR = 1;
  static const SUCCESS = 2;
  
  @override
  void initState() {
    items = widget.sellerInfo.sellerItems;
    quantityTextEditingControllers =
        items.map((_) => TextEditingController()).toList();
    priceTextEditingControllers =
        items.map((_) => TextEditingController()).toList();
    super.initState();
  }

  void _routeToBuyerBidConfirmationScreen() {
    final Map<String, dynamic> sellerInfoMap = {
      'seller': widget.sellerInfo.seller,
      'bidItems': bidItems
    };
    Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
        arguments: sellerInfoMap);
  }

  @override
  Widget build(BuildContext context) {
    logger.d('recreating build');
    return Scaffold(
        bottomNavigationBar: ButtonView(
          onButtonPressed: () {
            validationMap.clear();
            bidItems.clear();
            for(int index = 0; index < items.length; index ++) {
              final quantityValue = quantityTextEditingControllers[index].text;
              final priceValue = priceTextEditingControllers[index].text;
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
              bidItems.add(BidItem(item: item, bidCost: double.parse(priceValue), bidQuantity: double.parse(quantityValue)));
            }

            if(validationMap.containsKey(ERROR)) {
              logger.d('Validation error');
              return;
            }

            if(validationMap.containsKey(SUCCESS)) {
              logger.d('Validation success');
              _routeToBuyerBidConfirmationScreen();
              return;
            }

            logger.d('Validation Empty');
          },
          text: Constants.BUTTON_SUBMIT,
        ),
        appBar: HomeAppBar(text: widget.sellerInfo.seller.name),
        body: items != null && items.isEmpty
            ? Center(child: const Text('No data found'))
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        final Item item = items[index];
                        return CardView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: Text(
                                    item.displayName,
                                    style: TextStyle(
                                        fontSize: 22, color: AppColors.green),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 3,
                                      child: Text(
                                          'Available Qty : ${item.qty.toString()} Kgs',
                                          style: TextStyle(
                                              color: AppColors.text_black)),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextFormField(
                                        controller:
                                            quantityTextEditingControllers[
                                                index],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Quantity',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 3,
                                      child: Text(
                                        'Quoted Price : Rs.${item.price.toString()}',
                                        style: TextStyle(
                                            color: AppColors.text_black),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: TextFormField(
                                            controller:
                                                priceTextEditingControllers[
                                                    index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Price',
                                            ))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: items.length))
                    ],
                  ),
                ),
              ));
  }

  void updateValueMap(int key, int index) {
    if(validationMap.containsKey(key)) {
      final valuesList = validationMap[key];
      valuesList.add(index);
      validationMap[key] = valuesList;
    } else {
      validationMap[key] = [index];
    }
  }
}
