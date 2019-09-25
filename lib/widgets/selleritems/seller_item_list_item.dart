import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/commons/card_view.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item_row.dart';

class SellerItemListItem extends StatelessWidget {
  const SellerItemListItem(
      {this.item,
      this.quantityTextEditingController,
      this.priceTextEditingController,
      this.isEditable});

  final Item item;
  final TextEditingController quantityTextEditingController;
  final TextEditingController priceTextEditingController;
  final bool isEditable;

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
            SellerItemRow(
                isEditable: isEditable,
                text: 'Available Qty: ${item.qty.toString()} Kg',
                hintText: 'Order Qty',
                textEditingController: quantityTextEditingController),
            SellerItemRow(
                isEditable: isEditable,
                text:
                    'Estimated Price: ${Constants.INR_UNICODE} ${item.price.toString()}/Kg',
                hintText: 'Bid Price',
                textEditingController: priceTextEditingController),
          ],
        ),
      ),
    );
  }
}
