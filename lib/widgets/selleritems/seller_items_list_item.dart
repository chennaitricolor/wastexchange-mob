import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/card_view.dart';

class SellerItemsListItem extends StatelessWidget {
  const SellerItemsListItem(this.item);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return CardView(
        child: ListTile(
            title: Text(
              item.displayName,
              style:
                  const TextStyle(fontSize: 16.0, color: AppColors.text_black),
            ),
            subtitle: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 14.0, color: AppColors.text_grey),
                  children: [
                    TextSpan(text: '${item.qty.toString()}'),
                    const TextSpan(text: ' kg(s)'),
                  ]),
            ),
            trailing: RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 14.0, color: AppColors.text_grey),
                  children: [
                    const TextSpan(
                      text: '${Constants.INR_UNICODE} ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.text_black,
                      ),
                    ),
                    TextSpan(
                        text: item.price.toString(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.text_black)),
                    const TextSpan(
                        text: '/kg',
                        style: TextStyle(color: AppColors.text_black)),
                  ]),
            )));
  }
}
