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
  List<BidItemWidget> bidItemWidgets = List<BidItemWidget>();
  @override
  _SellerInformationScreenState createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  @override
  void initState() {
    super.initState();
    // DUmmy Data
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
    if (widget.sellerInfo.sellerItems.isNotEmpty) {
      widget.bidItems = Set.of(
          BidItem.mapItemListToBidItemList(widget.sellerInfo.sellerItems));
      for (int index = 0; index < widget.bidItems.length; index++) {
        widget.bidItemWidgets.add(BidItemWidget(
            index: index,
            commodity: widget.bidItems.elementAt(index),
            onSaveItem: saveBidItem,
            onDeleteItem: deleteBidItem));
      }
    }
  }

  void saveBidItem(int index, double bidQty, double bidAmount) {
    debugPrint('^^^^^^^^^^^^^^^^^^^ ${bidQty} ${bidAmount}');
    setState(() {
      widget.bidItems.elementAt(index).bidPrice = bidAmount;
      widget.bidItems.elementAt(index).bidQuantity = bidQty;
    });
  }

  void deleteBidItem(int index) {
    setState(() {
      widget.bidItems.elementAt(index).bidPrice = null;
      widget.bidItems.elementAt(index).bidQuantity = null;
    });
  }

  void validateForms(){
    widget.bidItemWidgets.forEach((form)=> {
       form.isValid()
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data Block
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,  
        actions: <Widget>[RaisedButton(
                    color: Colors.green[300],
                    textColor: Colors.white,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      validateForms();
                    },
                    child: Text('Add'),
                  )],
        title: ListTile(
          title: Text(widget.sellerInfo.seller.name,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          subtitle: Text(widget.sellerInfo.seller.address,
              style: TextStyle(color: Colors.white, fontSize: 13)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
        ]),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return widget.bidItemWidgets[index];
          },
        ),
      ),
    );
  }
}
