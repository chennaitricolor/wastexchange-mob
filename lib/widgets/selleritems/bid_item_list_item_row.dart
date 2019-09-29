import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class BidItemRow extends Row {
  BidItemRow(
      {@required this.keyText, @required this.valueText})
      : assert(isNotNull(keyText), 'The key text should not be null'),
        assert(isNotNull(valueText), 'The value text should not be null'),
        super(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Text(keyText, style: AppTheme.body1),
            ),
            Flexible(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(valueText, style: AppTheme.body1))
            ),
          ],
        );

  final String keyText;
  final String valueText;
}
