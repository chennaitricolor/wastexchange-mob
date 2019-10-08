import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class SellerItemBottomSheetListItem extends StatelessWidget {
  const SellerItemBottomSheetListItem(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return CardView(
        child: ListTile(
            title: Text(
              item.displayName,
              style: AppTheme.title,
            ),
            subtitle:
                Text('${item.qty.toString()} kg', style: AppTheme.subtitle),
            trailing: Text('${formattedPrice(item.price)}/Kg')));
  }
}
