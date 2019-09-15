import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/screens/seller_bid_screen.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item_row.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class SellerItemListItem extends StatelessWidget {
  const SellerItemListItem(
      {this.item,
        this.bidData,
        this.quantityTextEditingController,
        this.priceTextEditingController,
        this.sellerBidFlow});

  final Item item;
  final dynamic bidData;
  final TextEditingController quantityTextEditingController;
  final TextEditingController priceTextEditingController;
  final SellerBidFlow sellerBidFlow;

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
            sellerBidFlow == SellerBidFlow.bidFlow ? displayBidQuantity(): displayAvailableQuantityBidEditView(),
            sellerBidFlow == SellerBidFlow.bidFlow ? displayBidPrice() :displayEstimatedPriceAndBidPriceEditView(),
          ],
        ),
      ),
    );
  }

  Widget displayBidQuantity() {
    return SellerItemRow(
      text: 'Bid Qty:',
      hintText: "${bidData["bidQuantity"]}  Kg",
      textEditingController: quantityTextEditingController, isEditable: true);
  }

  Widget displayBidPrice() {
    return SellerItemRow(
        text:
        'Bid Price:',
        hintText: "${Constants.INR_UNICODE} ${bidData["bidCost"]}/Kg",
        textEditingController: priceTextEditingController, isEditable: true);
  }

  Widget displayEstimatedPriceAndBidPriceEditView() {
    return SellerItemRow(text:
    'Estimated Price: ${Constants.INR_UNICODE} ${item.price.toString()}/Kg',
        hintText: 'Bid Price',
        textEditingController: priceTextEditingController);
  }

  Widget displayAvailableQuantityBidEditView() {
    return SellerItemRow(
        text: 'Available Qty: ${item.qty.toString()} Kg',
        hintText: 'Order Qty',
        textEditingController: quantityTextEditingController);
  }
}
