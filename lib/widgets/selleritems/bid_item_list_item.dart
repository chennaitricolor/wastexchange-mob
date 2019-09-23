import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/commons/card_view.dart';
import 'package:wastexchange_mobile/widgets/selleritems/bid_item_list_item_row.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item_row.dart';

class BidItemListItem extends StatelessWidget {
  const BidItemListItem(
      {this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return CardView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Align(
              child: Text(
                item.displayName,
                style: AppTheme.title,
              ),
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 8),
            BidItemRow(
                keyText: 'Bid Qty        : ', valueText: '   ${item.qty.toString()} Kg'),
            BidItemRow(
                keyText:
                    'Bid Price      : ', valueText: '${Constants.INR_UNICODE} ${item.price.toString()}/Kg')
          ],
        ),
      ),
    );
  }
}
