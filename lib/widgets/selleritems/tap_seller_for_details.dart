import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';

class TapSellerForDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          AppLocalizations.translate(context, LocaleConstants.TAP_SELLER_FOR_DETAILS),
          style: AppTheme.body1,
          textAlign: TextAlign.center,
        ));
  }
}
