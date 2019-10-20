import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/core/utils/app_theme.dart';
import 'package:wastexchange_mobile/core/utils/constants.dart';
import 'package:wastexchange_mobile/core/utils/global_utils.dart';
import 'package:wastexchange_mobile/features/home/presentation/widgets/seller_item_bottom_sheet_list_item.dart';

class SellerItemBottomSheetList extends StatelessWidget {
  SellerItemBottomSheetList({
    Key key,
    @required this.items,
  })  : assert(isNotNull(items)),
        super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    const itemsEmptyWidget = Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          Constants.ITEMS_UNAVAILABLE,
          style: AppTheme.body1,
          textAlign: TextAlign.center,
        ));

    final itemsAvailableWidget = ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return SellerItemBottomSheetListItem(item);
      },
    );

    return items.isEmpty ? itemsEmptyWidget : itemsAvailableWidget;
  }
}
