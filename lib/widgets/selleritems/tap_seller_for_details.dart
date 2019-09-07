import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

import 'package:wastexchange_mobile/utils/constants.dart';

class TapSellerForDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        Constants.TAP_SELLER_FOR_DETAILS,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
