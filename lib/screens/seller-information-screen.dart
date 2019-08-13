import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';

import 'bid_item_widget.dart';


class SellerInformationScreen extends StatefulWidget{

  SellerInformationScreen({this.sellerInfo});
  SellerInformation sellerInfo;
  List<BidItem> bidItems;
  @override
  _SellerInformationScreenState createState() => _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {

 @override
 void initState(){
   super.initState();
  //  if(widget.sellerInfo.sellerItems.length > 0)
  //   widget.bidItems = BidItem.mapItemListToBidItemList(widget.sellerInfo.sellerItems);
 }

  @override
  Widget build(BuildContext context) {
    // widget.bidItems[0] = BidItem(name: 'Plastic', specifiedPRice: 20.0, availableQuantity: 10);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Seller Information'),),
      body: Container(child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context,int index){
           return BidItemWidget(commodity: BidItem(name: 'Plastic', specifiedPRice: 20.0, availableQuantity: 10));
        },
      ),)
    ,);
  }
}