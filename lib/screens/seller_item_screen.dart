import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/seller_item.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:flushbar/flushbar_helper.dart';

class SellerItemScreen extends StatefulWidget {
  const SellerItemScreen({this.sellerInfo});

  final SellerItem sellerInfo;

  static const routeName = '/sellerItemScreen';

  @override
  _SellerItemScreenState createState() => _SellerItemScreenState();
}



class _SellerItemScreenState extends State<SellerItemScreen> with SellerItemListener {
  final _formKey = GlobalKey<FormState>();
  final logger = AppLogger.get('SellerInformationScreen');
  Map<int, List<int>> validationMap = {};
  SellerItemBloc sellerItemBloc;

  @override
  void initState() {
    sellerItemBloc = SellerItemBloc(this, widget.sellerInfo.sellerItems);
    super.initState();
  }

  @override
  void dispose() {
    sellerItemBloc = null;
    super.dispose();
  }

  @override
  void goToBidConfirmationPage(List<BidItem> bidItems) {
    final Map<String, dynamic> sellerInfoMap = {
      'seller': widget.sellerInfo.seller,
      'bidItems': bidItems
    };
    Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
        arguments: sellerInfoMap);
  }

  @override
  void onValidationError(String message) {
    Flushbar(
      duration: Duration(seconds: 3),
      title: 'Validation Error',
      message: message,)..show(context);
  }

  @override
  Widget build(BuildContext context) {
     final List<Item> items = sellerItemBloc.items;
    return Scaffold(
        bottomNavigationBar: ButtonView(
          onButtonPressed: () {
            sellerItemBloc.onSubmitBids();
          },
          text: Constants.BUTTON_SUBMIT,
        ),
        appBar: HomeAppBar(text: widget.sellerInfo.seller.name),
        body: Form(
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
                                        controller: sellerItemBloc.quantityTextEditingController(index),
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
                                            controller: sellerItemBloc.priceTextEditingController(index),
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


}

mixin SellerItemListener {
  void goToBidConfirmationPage(List<BidItem> bidItems);
  void onValidationError(String message);
}
