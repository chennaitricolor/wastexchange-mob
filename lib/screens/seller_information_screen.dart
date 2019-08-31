import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/logger.dart';
import 'package:wastexchange_mobile/widgets/card_view.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

//TODO Rename this to SellerItemsScreen
class SellerInformationScreen extends StatefulWidget {
  SellerInformation sellerInfo;

  SellerInformationScreen({this.sellerInfo});

  static const routeName = '/sellerInformationScreen';

  @override
  _SellerInformationScreenState createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  List<BidItem> bidItems;
  final logger = getLogger('Seller Information Screen');
  List<TextEditingController> quantityTextEditingControllers = [];
  List<TextEditingController> priceTextEditingControllers = [];

  @override
  void initState() {
    bidItems = BidItem.bidItemsForItems(widget.sellerInfo.sellerItems);
    quantityTextEditingControllers =
        bidItems.map((bidItem) => TextEditingController()).toList();
    priceTextEditingControllers =
        bidItems.map((bidItem) => TextEditingController()).toList();
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
            bidItems
                .forEach((item) => {item.bidCost = 1, item.bidQuantity = 1});
            _routeToBuyerBidConfirmationScreen();
          },
          buttonText: Constants.BUTTON_SUBMIT,
          margin: const EdgeInsets.all(24),
          buttonStyle: ButtonStyle.DEFAULT,
        ),
        appBar: HomeAppBar(
          title: ListTile(
            title: Text(widget.sellerInfo.seller.name,
                style: TextStyle(fontSize: 20)),
            subtitle: Text(widget.sellerInfo.seller.address,
                style: TextStyle(fontSize: 13)),
          ),
        ),
        body: bidItems != null && bidItems.isEmpty
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
                        BidItem bidItem = bidItems[index];
                        return CardView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: Text(
                                    bidItem.item.displayName,
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
                                          'Available Qty : ${bidItem.item.qty.toString()} Kgs',
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            bidItem.bidQuantity = 0;
                                            updateBidItems(index, bidItem);
                                            return null;
                                          }
                                          final quantity = double.parse(value);
                                          bidItem.bidQuantity = quantity;
                                          updateBidItems(index, bidItem);
                                          return null;
                                        },
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
                                        'Quoted Price : Rs.${bidItem.item.price.toString()}',
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
                                            ),
//                          controller: priceController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                bidItem.bidCost = 0;
                                                updateBidItems(index, bidItem);
                                                return null;
                                              }
                                              bidItem.bidCost =
                                                  double.parse(value);
                                              updateBidItems(index, bidItem);
                                              return null;
                                            })),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: bidItems.length))
                    ],
                  ),
                ),
              ));
  }

  void updateBidItems(int index, BidItem bidItem) {
    bidItems[index] = bidItem;
  }
}
