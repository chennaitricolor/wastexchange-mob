import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/rectangle_button_view.dart';

class OrderFormTotal extends StatelessWidget {
  const OrderFormTotal({this.total, this.itemsCount, this.onPressed});

  final double total;
  final int itemsCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 90,
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
                            text:
                                '${Constants.INR_UNICODE}${total.toStringAsFixed(2)}',
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
        RaisedButton.icon(
            color: AppColors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0)),
            onPressed: onPressed,
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 25,
            ),
            label: Text(
              'Confirm',
              style: AppTheme.buttonTitle,
            ))
      ]),
    );
  }
}
