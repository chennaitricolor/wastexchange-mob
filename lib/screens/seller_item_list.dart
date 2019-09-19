import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item.dart';

class SellerItemList extends StatelessWidget {
  SellerItemList({this.bidItems, this.quantityEditingControllers, this.priceEditingControllers});

  final List<BidItem> bidItems;
  final List<TextEditingController> quantityEditingControllers;
  final List<TextEditingController> priceEditingControllers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          final Item item = bidItems[index].item;
          return SellerItemListItem(
              item: item,
              quantityTextEditingController: quantityEditingControllers[index],
              priceTextEditingController: priceEditingControllers[index]);
        }, childCount: bidItems.length))
      ],
    );
  }
}
