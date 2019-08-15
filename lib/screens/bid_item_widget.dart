import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';

class BidItemWidget extends StatefulWidget {
  const BidItemWidget({Key key, this.commodity, this.onSaveItem})
      : super(key: key);
  final BidItem commodity;
  final Function(int index, double bidQty, double bidAmt) onSaveItem;
  @override
  _BidItemWidgetState createState() => _BidItemWidgetState();
}

class _BidItemWidgetState extends State<BidItemWidget> {
  final _formKey = GlobalKey<FormState>();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();

  //Styling
  final EdgeInsets all10 = EdgeInsets.all(10.0);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    qtyController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: all10,
        padding: all10,
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
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      'Available Qty : ${widget.commodity.availableQuantity.toString()}'),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      
                      decoration: InputDecoration.collapsed(
                        hintText: 'Quantity',
                        // border: InputBorder(borderSide: BorderSide.lerp(a, b, t)),
                      ),
                      controller: qtyController,
                      validator: (value) {
                        if (double.parse(value) >
                            widget.commodity.availableQuantity) return '> qty';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    'Quoted Price : ${widget.commodity.specifiedPRice.toString()}'),
                SizedBox(
                    width: 100,
                    child: TextFormField(
                      decoration: new InputDecoration.collapsed(
                        hintText: 'Price',
                      ),
                      controller: priceController,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green[300],
                  textColor: Colors.white,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      widget.onSaveItem(0, double.parse(qtyController.text),
                          double.parse(priceController.text));
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
