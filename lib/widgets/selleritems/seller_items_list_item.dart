import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class SellerItemsListItem extends StatelessWidget {
  const SellerItemsListItem(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return CardView(
        child: ListTile(
            title: Text(
              item.displayName,
              style: AppTheme.title,
            ),
            subtitle: RichText(
              text: TextSpan(style: AppTheme.subtitle, children: [
                TextSpan(text: '${item.qty.toString()}'),
                const TextSpan(text: ' kg(s)'),
              ]),
            ),
            trailing: RichText(
              text: TextSpan(style: AppTheme.subtitle, children: [
                const TextSpan(
                  text: '${Constants.INR_UNICODE} ',
                  style: AppTheme.caption,
                ),
                TextSpan(text: item.price.toString(), style: AppTheme.title),
                const TextSpan(text: '/kg', style: AppTheme.caption),
              ]),
            )));
  }
}
