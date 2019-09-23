import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/widgets/selleritems/bid_item_list_item.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item.dart';

class BidItemList extends StatelessWidget {
  const BidItemList(
      {this.bidItems});

  final List<BidItem> bidItems;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          final Item item = bidItems[index].item;
          return BidItemListItem(
              item: item);
        }, childCount: bidItems.length))
      ],
    );
  }
}
