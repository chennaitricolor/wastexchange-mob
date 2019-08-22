import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';

class BidItemWidget extends StatefulWidget {
  BidItemWidget(
      {Key key, this.index, this.commodity, this.onSaveItem, this.onDeleteItem})
      : super(key: key);

  final state = _BidItemWidgetState();
  final int index;
  final BidItem commodity;

  final Function(int index, double bidQty, double bidAmt) onSaveItem;
  final Function(int index) onDeleteItem;
  @override
  _BidItemWidgetState createState() => state;

  bool isValid() => state.validate();
}

class _BidItemWidgetState extends State<BidItemWidget> {
  final _formKey = GlobalKey<FormState>();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();

  //Styling
  static const EdgeInsets all10 = EdgeInsets.all(10.0);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    qtyController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void removeCommodityFromBid() {
    widget.onDeleteItem(widget.index);
    qtyController.text = '';
    priceController.text = '';
  }

  bool isTextNullOrEmpty(String str) {
    return str == '' || str == null;
  }

  bool validate() {
    final valid = _formKey.currentState.validate();
    if (valid &&
        !isTextNullOrEmpty(qtyController.text) &&
        !isTextNullOrEmpty(priceController.text)) {
      widget.onSaveItem(widget.index, double.parse(qtyController.text),
          double.parse(priceController.text));
    }
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        padding: all10,
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            offset: const Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
        ]),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  widget.commodity.name,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Text(
                      'Available Qty : ${widget.commodity.availableQuantity.toString()} Kgs'),
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Quantity',
                    ),
                    controller: qtyController,
                    validator: (value) {
                      if (value != '' &&
                          double.parse(value) >
                              widget.commodity.availableQuantity)
                        return '> qty';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Text(
                      'Quoted Price : Rs.${widget.commodity.specifiedPRice.toString()}'),
                ),
                Flexible(
                    flex: 1,
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Price',
                        ),
                        controller: priceController,
                        validator: (value) {
                          if (value != '' && double.parse(value) < 0)
                            return '< 0';
                          return null;
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
