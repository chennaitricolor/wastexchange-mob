import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/tap_seller_for_details.dart';
import 'package:wastexchange_mobile/widgets/views/app_intro_message.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';

class SellerItemBottomSheetHeaderEmpty extends StatelessWidget {
  const SellerItemBottomSheetHeaderEmpty(
      {@required VoidCallback onPressed, @required bool isAuthorized})
      : _onPressed = onPressed,
        _isAuthorized = isAuthorized;

  final VoidCallback _onPressed;
  final bool _isAuthorized;

  @override
  Widget build(BuildContext context) {
    final loggedOutWidgets = [
      ButtonView(
          onButtonPressed: _onPressed,
          text: AppLocalizations.translate(context, LocaleConstants.LOGIN_TO_BUY),
          insetL: 10.0,
          insetT: 10.0,
          insetR: 10.0,
          insetB: 10.0),
      AppIntroMessage(AppLocalizations.translate(context, LocaleConstants.ANNOUNCEMENT_MESSAGE)),
      AppIntroMessage(AppLocalizations.translate(context, LocaleConstants.USER_ENCOURAGE_LOGIN_MESSAGE)),
    ];
    final loggedInWidgets = [TapSellerForDetails()];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
              Icon(
                Icons.drag_handle,
                size: 25.0,
              ),
            ] +
            (_isAuthorized ? loggedInWidgets : loggedOutWidgets));
  }
}
