import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class SellerItemCell extends StatelessWidget {
  const SellerItemCell(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    item.name,
                    style: TextStyle(fontSize: 24.0, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                          children: [
                            TextSpan(
                                text: '${item.qty.toString()}',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.brown)),
                            const TextSpan(text: ' kg(s) ('),
                            TextSpan(
                              text: '${Constants.INR_UNICODE} ',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            TextSpan(
                                text: item.price.toString(),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blue)),
                            const TextSpan(text: '/kg)'),
                          ]),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
