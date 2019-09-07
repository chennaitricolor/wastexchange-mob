import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

import 'package:wastexchange_mobile/utils/constants.dart';

class TapSellerForDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Icon(
        Icons.drag_handle,
        size: 25.0,
      ),
      const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            Constants.TAP_SELLER_FOR_DETAILS,
            style: AppTheme.body1,
            textAlign: TextAlign.center,
          ))
    ]);
  }
}
