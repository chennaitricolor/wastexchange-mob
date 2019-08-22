import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

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
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return SellerItemCell(item);
      },
    );
  }
}
