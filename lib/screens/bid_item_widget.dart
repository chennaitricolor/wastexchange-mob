import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';

class BidItemWidget extends StatefulWidget{
    const BidItemWidget({Key key, this.commodity}): super(key: key);
  final BidItem commodity;
  @override
  _BidItemWidgetState createState() => _BidItemWidgetState();
}

class _BidItemWidgetState extends State<BidItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text(widget.commodity.name),
        
        Text(widget.commodity.availableQuantity.toString()),
        Text(widget.commodity.specifiedPRice.toString()),
        // Text(widget.commodity.),
        // Text(widget.commodity.),
      ],),
    );
  }
}