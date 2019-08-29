import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:authentication_view/auth_colors.dart';

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
      child: Card(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        // padding: all10,
        // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    widget.commodity.item.name,
                    style: TextStyle(fontSize: 25, color: AuthColors.green),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Text(
                        'Available Qty : ${widget.commodity.item.qty.toString()} Kgs'),
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
                            double.parse(value) > widget.commodity.item.qty)
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
                        'Quoted Price : Rs.${widget.commodity.item.price.toString()}'),
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
      ),
    );
  }
}
