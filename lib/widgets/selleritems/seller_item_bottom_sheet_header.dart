import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_compact.dart';

class SellerItemBottomSheetHeader extends StatelessWidget {
  const SellerItemBottomSheetHeader(
      {@required this.onPressed,
      @required this.name,
      @required this.isAuthorized,
      @required this.hasItems});

  final VoidCallback onPressed;
  final String name;
  final bool isAuthorized;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final buttonTitle =
        isAuthorized ? AppLocalizations.translate(context, LocaleConstants.BID_TO_BUY) 
        : AppLocalizations.translate(context, LocaleConstants.LOGIN_TO_BUY);
    final buttonEnabled = !isAuthorized || hasItems;
    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              name,
              style: AppTheme.body1,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ButtonViewCompact(
              text: buttonTitle,
              width: 140,
              enabled: buttonEnabled,
              onPressed: onPressed),
        ],
      ),
    );
  }
}
