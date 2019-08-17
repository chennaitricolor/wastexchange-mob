import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'bid_item_widget.dart';

class SellerInformationScreen extends StatefulWidget {
  SellerInformationScreen({this.sellerInfo});
  SellerInformation sellerInfo;
  Set<BidItem> bidItems;
  @override
  _SellerInformationScreenState createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  @override
  void initState() {
    super.initState();
    // DUmmy Data
  }

  void saveBidItem(int index, double bidQty, double bidAmount) {
    debugPrint('$index $bidQty $bidAmount');
    widget.bidItems.elementAt(index).bidPrice = bidAmount;
    widget.bidItems.elementAt(index).bidQuantity = bidQty;
    debugPrint('${widget.bidItems.elementAt(index).bidQuantity}');
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data Block
    final User dummyUser = User(
        id: 1,
        name: 'Chennai Dump Yard',
        address: 'No :1120, Perungudi , Chennai City');
    final List<Item> itemsList = [
      Item(name: 'Plastic', price: 20, qty: 10),
      Item(name: 'Paper', price: 10, qty: 100)
    ];
    widget.sellerInfo =
        SellerInformation(seller: dummyUser, sellerItems: itemsList);
    if (widget.sellerInfo.sellerItems.isNotEmpty)
      widget.bidItems =
          Set.of(BidItem.mapItemListToBidItemList(widget.sellerInfo.sellerItems));
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: ListTile(
          title: Text(widget.sellerInfo.seller.name,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          subtitle: Text(widget.sellerInfo.seller.address,
              style: TextStyle(color: Colors.white, fontSize: 13)),
        ),
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
