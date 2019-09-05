import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

import 'package:wastexchange_mobile/utils/constants.dart';

class TapSellerForDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      Constants.TAP_SELLER_FOR_DETAILS,
      style: AppTheme.headline,
      textAlign: TextAlign.center,
    );
  }
}
