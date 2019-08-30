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

  @override
  void initState() {
    bidItems = BidItem.mapItemListToBidItemList(widget.sellerInfo.sellerItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ButtonView(
          onButtonPressed: () {
            if (_formKey.currentState.validate()) {
              logger.d("Succes validation " + bidItems.toString());
              Map<String, dynamic> sellerInfoMap = {
                "seller": widget.sellerInfo.seller,
                "bidItems": bidItems
              };
              Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
                  arguments: sellerInfoMap);
            } else {
              logger.d("Failure validation " + bidItems.toString());
            }
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
            ? Center(child: Text('No data found'))
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                    itemCount: bidItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      BidItem bidItem = bidItems[index];
                      return CardView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                bidItem.item.displayName,
                                style: TextStyle(
                                    fontSize: 22, color: AppColors.green),
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
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Quantity',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Should not be empty';
                                        }
                                        var quantity = double.parse(value);
                                        if (quantity <= bidItem.item.qty) {
                                          bidItem.bidQuantity = quantity;
                                          updateBidItems(index, bidItem);
                                          return null;
                                        } else {
                                          return 'Quantity should be greater than the given quantity';
                                          ;
                                        }
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
                                      'Quoted Price : Rs.${bidItem.bidCost.toString()}',
                                      style: TextStyle(
                                          color: AppColors.text_black),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Price',
                                          ),
//                          controller: priceController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Should not be empty';
                                            } else {
                                              bidItem.bidCost =
                                                  double.parse(value);
                                              updateBidItems(index, bidItem);
                                              return null;
                                            }
                                          })),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ));
  }

  void updateBidItems(int index, BidItem bidItem) {
    bidItems[index] = bidItem;
  }
}
