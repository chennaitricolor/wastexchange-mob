import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/widgets/order_item.dart';

class OrderFormSummaryList extends StatelessWidget {
  factory OrderFormSummaryList({List<BidItem> items}) {
    ArgumentError.checkNotNull(items);
    if (items.isEmpty) {
      throw Exception('BidItems cannot be empty');
    }
    return OrderFormSummaryList._(items: items);
  }

  const OrderFormSummaryList._({List<BidItem> items}) : _items = items;
  final List<BidItem> _items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Container(
              height: 15,
              child: Divider(
                color: AppColors.grey,
                height: 1.0,
              )),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return OrderItem(_items[index]);
          }),
    );
  }
}
