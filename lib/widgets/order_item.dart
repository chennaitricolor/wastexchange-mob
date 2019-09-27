import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(this.bidItem);

  final BidItem bidItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
              child:
                  Text('${bidItem.item.displayName}', style: AppTheme.body2)),
          flex: 2,
        ),
        Expanded(
          child: Container(
              child: Text(
            'Qty: ${bidItem.bidQuantity} Kg',
            style: AppTheme.body2,
            textAlign: TextAlign.center,
          )),
          flex: 1,
        ),
        Expanded(
          child: Container(
              child: Text(
            '${Constants.INR_UNICODE} ${bidItem.bidCost}/Kg',
            style: AppTheme.body2,
            textAlign: TextAlign.right,
          )),
          flex: 1,
        ),
      ]),
      height: 44,
    );
  }
}
