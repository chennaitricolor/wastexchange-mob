import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:wastexchange_mobile/utils/logger.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'bid_item_widget.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

//TODO Rename this to SellerItemsScreen
class SellerInformationScreen extends StatefulWidget {
  const SellerInformationScreen({this.sellerInfo});
  static const routeName = '/sellerInformationScreen';

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
      Item(name: 'Paper', price: 10, qty: 100),
      Item(name: 'Metal', price: 10, qty: 100),
      Item(name: 'Wood', price: 10, qty: 100),
      Item(name: 'PET', price: 10, qty: 100)
    ];

    sellerInfo = SellerInformation(seller: dummyUser, sellerItems: itemsList);
    if (sellerInfo.sellerItems.isNotEmpty) {
      _bidItems =
          Set.of(BidItem.mapItemListToBidItemList(sellerInfo.sellerItems));
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
      appBar: HomeAppBar(
        title: ListTile(
          title: Text(sellerInfo.seller.name, style: TextStyle(fontSize: 20)),
          subtitle:
              Text(sellerInfo.seller.address, style: TextStyle(fontSize: 13)),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return _bidItemWidgets[index];
              },
            ),
          ),
          ButtonView(
            onButtonPressed: () {
              final bool valid = isFormsValid();
              logger.d(valid);
            },
            buttonText: Constants.CHECKOUT,
            margin: const EdgeInsets.all(16),
            buttonStyle: ButtonStyle.DEFAULT,
          )
        ],
      ),
    );
  }
}
