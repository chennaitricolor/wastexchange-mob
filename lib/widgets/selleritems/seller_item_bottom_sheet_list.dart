import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_list_item.dart';

class SellerItemBottomSheetList extends StatelessWidget {
  const SellerItemBottomSheetList({
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
        return SellerItemBottomSheetListItem(item);
      },
    );
  }
}
