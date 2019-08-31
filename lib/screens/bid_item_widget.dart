import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:authentication_view/auth_colors.dart';
import 'package:wastexchange_mobile/models/item.dart';

class BidItemWidget extends StatefulWidget {
  BidItemWidget({this.items});

  final List<Item> items;

  @override
  _BidItemWidgetState createState() => _BidItemWidgetState();

//  ValidationCallback onQuanityValidation;
//  ValidationCallback onPriceValidation;
//
//  Map<String, String> quantify = {};
//  Map<String, String> values = {};

//  bool isValid() => state.validate();
}

class _BidItemWidgetState extends State<BidItemWidget> {
  final _formKey = GlobalKey<FormState>();

//  final qtyController = TextEditingController();
//  final priceController = TextEditingController();

  //Styling

  List<Item> items;

  List<BidItem> bidItems = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
//    qtyController.dispose();
//    priceController.dispose();
    super.dispose();
  }

//  void removeCommodityFromBid() {
//    widget.onDeleteItem(widget.index);
//    qtyController.text = '';
//    priceController.text = '';
//  }

//  bool isTextNullOrEmpty(String str) {
//    return str == '' || str == null;
//  }

//  bool validate() {
//    final valid = _formKey.currentState.validate();
//    if (valid &&
//        !isTextNullOrEmpty(qtyController.text) &&
//        !isTextNullOrEmpty(priceController.text)) {
//      widget.onSaveItem(widget.index, double.parse(qtyController.text),
//          double.parse(priceController.text));
//    }
//    return valid;
//  }

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Item bidItem = items.elementAt(index);
          return Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            // padding: all10,
            // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Column(
              children: <Widget>[
                Text(
                  bidItem.name,
                  style: TextStyle(fontSize: 25, color: AuthColors.green),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child:
                          Text('Available Qty : ${bidItem.qty.toString()} Kgs'),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty && double.parse(value) <= bidItem.qty) {
                            return null;
                          }
                          return 'Quantity should be greater than the given quantity';;
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
//                          'Quoted Price'),
                          'Quoted Price : Rs.${bidItem.price.toString()}'),
                    ),
                    Flexible(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Price',
                            ),
//                          controller: priceController,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {

                                return null;
                              }
                              return 'Should not be empty';;
                            })),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

typedef ValidationCallback = void Function(
    bool isValidationSuccess, Map<String, String> valueMap);
