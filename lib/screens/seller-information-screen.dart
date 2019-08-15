import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/user.dart';

import 'bid_item_widget.dart';

class SellerInformationScreen extends StatefulWidget {
  SellerInformationScreen({this.sellerInfo});
  SellerInformation sellerInfo;
  List<BidItem> bidItems = [];
  @override
  _SellerInformationScreenState createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  void saveBidItem(int index, double bidQty, double bidAmount) {
    debugPrint('$index $bidQty $bidAmount');
    widget.bidItems.elementAt(index).bidPrice = bidAmount;
    widget.bidItems.elementAt(index).bidQuantity = bidQty;
    debugPrint('${widget.bidItems.elementAt(index).bidQuantity}');
  }

  @override
  Widget build(BuildContext context) {
    final User dummyUser = User(id: 1, name: 'Surya');
    final List<Item> itemsList = [
      Item(name: 'Plastic', price: 20, qty: 10),
      Item(name: 'Paper', price: 10, qty: 100)
    ];
    widget.sellerInfo =
        SellerInformation(seller: dummyUser, sellerItems: itemsList);
    if (widget.sellerInfo.sellerItems.isNotEmpty)
      widget.bidItems =
          BidItem.mapItemListToBidItemList(widget.sellerInfo.sellerItems);
    // TODO(Sayeed): implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Information'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return BidItemWidget(
                commodity: widget.bidItems.elementAt(index),
                onSaveItem: saveBidItem);
          },
        ),
      ),
    );
  }
}
