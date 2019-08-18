import 'package:flutter/material.dart';

import 'package:wastexchange_mobile/widgets/seller_item_cell.dart';
import 'package:wastexchange_mobile/models/item.dart';

class SellerItemList extends StatelessWidget {
  const SellerItemList({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
        endIndent: 16.0,
        indent: 16.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return SellerItemCell(item);
      },
    );
  }
}
