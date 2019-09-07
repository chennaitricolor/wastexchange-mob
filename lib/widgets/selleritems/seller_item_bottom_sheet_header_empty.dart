import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/tap_seller_for_details.dart';
import 'package:wastexchange_mobile/widgets/views/app_intro_message.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';

class SellerItemBottomSheetHeaderEmpty extends StatelessWidget {
  const SellerItemBottomSheetHeaderEmpty({
    @required VoidCallback onPressed,
  }) : _onPressed = onPressed;

  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    if (TokenRepository().isAuthorized()) {
      return TapSellerForDetails();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ButtonView(
          onButtonPressed: _onPressed,
          text: Constants.LOGIN_TO_BUY,
        ),
        const AppIntroMessage(Constants.ANNOUNCEMENT_MESSAGE),
        const AppIntroMessage(Constants.USER_ENCOURAGE_LOGIN_MESSAGE),
      ],
    );
  }
}
