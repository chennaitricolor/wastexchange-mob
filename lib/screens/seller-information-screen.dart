import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/logger.dart';
import 'bid_item_widget.dart';

class SellerInformationScreen extends StatefulWidget {
  const SellerInformationScreen({this.sellerInfo});
  final SellerInformation sellerInfo;
  @override
  _SellerInformationScreenState createState() =>
      _SellerInformationScreenState(sellerInfo: sellerInfo);
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  _SellerInformationScreenState({this.sellerInfo});

  Set<BidItem> _bidItems = {};
  final List<BidItemWidget> _bidItemWidgets = [];
  SellerInformation sellerInfo;
  Logger logger = getLogger('SellerInformationScreen');

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

    sellerInfo = SellerInformation(seller: dummyUser, sellerItems: itemsList);
    if (widget.sellerInfo.sellerItems.isNotEmpty) {
      _bidItems = Set.of(
          BidItem.mapItemListToBidItemList(widget.sellerInfo.sellerItems));
      for (int index = 0; index < _bidItems.length; index++) {
        _bidItemWidgets.add(BidItemWidget(
            index: index,
            commodity: _bidItems.elementAt(index),
            onSaveItem: saveBidItem,
            onDeleteItem: deleteBidItem));
      }
    }
  }

  void saveBidItem(int index, double bidQty, double bidAmount) {
    logger.d('^^^^^^^^^^^^^^^^^^^ $bidQty $bidAmount');
    setState(() {
      _bidItems.elementAt(index).bidPrice = bidAmount;
      _bidItems.elementAt(index).bidQuantity = bidQty;
    });
  }

  void deleteBidItem(int index) {
    setState(() {
      _bidItems.elementAt(index).bidPrice = null;
      _bidItems.elementAt(index).bidQuantity = null;
    });
  }

  bool isFormsValid() {
    return _bidItemWidgets.firstWhere((form) => !form.isValid(),
            orElse: () => null) ==
        null;
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data Block
    // TODO(Surya): implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: <Widget>[
          RaisedButton(
            color: Colors.green[300],
            textColor: Colors.white,
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              final bool valid = isFormsValid();
              logger.d(valid);
            },
            child: const Text('Add'),
          )
        ],
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
            offset: const Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
        ]),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return _bidItemWidgets[index];
          },
        ),
      ),
    );
  }
}
