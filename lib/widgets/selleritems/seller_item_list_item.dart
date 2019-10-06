import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item_row.dart';

class SellerItemListItem extends StatelessWidget {
  const SellerItemListItem(
      {this.item,
      this.showQuantityFieldError,
      this.showPriceFieldError,
      this.quantityTextEditingController,
      this.priceTextEditingController,
      this.isEditable});

  final Item item;
  final bool showQuantityFieldError;
  final bool showPriceFieldError;
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
                showFieldError: showQuantityFieldError ?? false,
                isEditable: isEditable,
                text: 'Available Qty: ${item.qty.toString()} Kg',
                hintText: 'Order Qty',
                textEditingController: quantityTextEditingController),
            SellerItemRow(
                showFieldError: showPriceFieldError ?? false,
                isEditable: isEditable,
                text: item.price == 0 ? 'Estimated Price: Free' : 'Estimated Price: ${formattedPrice(item.price)}/Kg' ,
                hintText: 'Bid Price',
                textEditingController: priceTextEditingController),
          ],
        ),
      ),
    );
  }
}
