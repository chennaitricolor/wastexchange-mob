import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_list_item.dart';

class SellerItemBottomSheetList extends StatelessWidget {
  SellerItemBottomSheetList({
    Key key,
    @required this.items,
  }) : super(key: key) {
    ArgumentError.checkNotNull(items);
  }

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final itemsEmptyWidget = Padding(
        padding: EdgeInsets.all(16.0),
        child: 
          Text(
          AppLocalizations.translate(context, LocaleConstants.ITEMS_UNAVAILABLE),
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
