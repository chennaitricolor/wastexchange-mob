import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class OrderTotal extends StatelessWidget {
  const OrderTotal({this.total, this.itemsCount, this.onPressed});

  final double total;
  final int itemsCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: AppColors.green, width: 1.0))),
        child: Row(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
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
                      ])),
              flex: 1),
          Expanded(
              child: SizedBox(
                  height: 44,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: RaisedButton(
                          color: AppColors.green,
                          child: Row(
                            children: <Widget>[
                              const Text(
                                'Confirm',
                                style: AppTheme.buttonTitle,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          onPressed: () {
                            onPressed();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0))))),
              flex: 1)
        ]));
  }
}
