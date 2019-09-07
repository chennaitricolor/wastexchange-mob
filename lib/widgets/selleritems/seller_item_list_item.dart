import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item_row.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class SellerItemListItem extends StatelessWidget {
  const SellerItemListItem(
      {this.item,
      this.quantityTextEditingController,
      this.priceTextEditingController});

  final Item item;
  final TextEditingController quantityTextEditingController;
  final TextEditingController priceTextEditingController;

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
                text: 'Available Qty : ${item.qty.toString()} Kgs',
                hintText: 'Quantity',
                textEditingController: quantityTextEditingController),
            SellerItemRow(
                text: 'Quoted Price : Rs.${item.price.toString()}',
                hintText: 'Price',
                textEditingController: priceTextEditingController),
          ],
        ),
      ),
    );
  }
}