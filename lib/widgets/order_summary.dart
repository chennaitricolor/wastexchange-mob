import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/order_item.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({this.items});

  final List<BidItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text('Order Summary', style: AppTheme.title),
      Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    color: AppColors.grey,
                    height: 1.0,
                  ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return OrderItem(items[index]);
              }))
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }
}
