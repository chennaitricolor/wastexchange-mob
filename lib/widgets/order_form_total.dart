import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/bottom_action_view_container.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_icon_compact.dart';

class OrderFormTotal extends StatelessWidget {
  // TODO(Sayeed): Should we change this to resemble OrderFormSummaryList constructor
  const OrderFormTotal({this.total, this.itemsCount, this.onPressed});

  final double total;
  final int itemsCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BottomActionViewContainer(
      children: <Widget>[
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: AppTheme.title,
                      children: <TextSpan>[
                        const TextSpan(text: 'Total: '),
                        TextSpan(
                            text: formattedPrice(total), style: AppTheme.body1),
                      ],
                    ),
                  ),
                  Text(
                    '$itemsCount item' + (itemsCount == 1 ? '' : 's'),
                    style: AppTheme.body2,
                  )
                ]),
            flex: 1),
        ButtonViewIconCompact(text: 'Confirm', onPressed: onPressed)
      ],
    );
  }
}
