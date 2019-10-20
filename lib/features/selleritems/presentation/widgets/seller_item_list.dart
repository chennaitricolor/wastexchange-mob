import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/features/selleritems/presentation/widgets/seller_item_list_item.dart';

class SellerItemList extends StatelessWidget {
  const SellerItemList(
      {this.bidItems,
      this.quantityErrorPositions,
      this.priceErrorPositions,
      this.quantityEditingControllers,
      this.priceEditingControllers});

  final List<BidItem> bidItems;
  final Set<int> quantityErrorPositions;
  final Set<int> priceErrorPositions;
  final List<TextEditingController> quantityEditingControllers;
  final List<TextEditingController> priceEditingControllers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final Item item = bidItems[index].item;
          return SellerItemListItem(
              isEditable: true,
              showQuantityFieldError: quantityErrorPositions.contains(index),
              showPriceFieldError: priceErrorPositions.contains(index),
              item: item,
              quantityTextEditingController: quantityEditingControllers[index],
              priceTextEditingController: priceEditingControllers[index]);
        }, itemCount : bidItems.length);
  }
}
