import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_icon_compact.dart';

class OrderFormTotal extends StatelessWidget {
  const OrderFormTotal({this.total, this.itemsCount, this.onPressed});

  final double total;
  final int itemsCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 80,
      padding: const EdgeInsets.all(16),
      child: Row(children: <Widget>[
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
                            text: '${Constants.INR_UNICODE}$total',
                            style: AppTheme.body1),
                      ],
                    ),
                  ),
                  Text(
                    '$itemsCount item' + (itemsCount == 1 ? '' : 's'),
                    style: AppTheme.body2,
                  )
                ]),
            flex: 1),
        ButtonViewIconCompact(text: 'Confirm', onPressed: onPressed),
      ]),
    );
  }
}
