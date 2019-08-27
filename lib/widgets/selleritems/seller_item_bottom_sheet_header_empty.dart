import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/announcement_message.dart';
import 'package:wastexchange_mobile/widgets/tap_seller_for_details.dart';

class SellerItemBottomSheetHeaderEmpty extends StatelessWidget {
  const SellerItemBottomSheetHeaderEmpty({
    @required VoidCallback onPressed,
  }) : _onPressed = onPressed;

  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = TokenRepository.sharedInstance.isAuthorized();
    if (isAuthenticated) {
      return TapSellerForDetails();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ButtonView(
          onButtonPressed: _onPressed,
          buttonText: Constants.LOGIN_TO_BUY,
          margin: const EdgeInsets.all(16),
          buttonStyle: ButtonStyle.DEFAULT,
        ),
        AnnouncementMessage(Constants.ANNOUNCEMENT_MESSAGE),
        AnnouncementMessage(Constants.USER_ENCOURAGE_LOGIN_MESSAGE),
      ],
    );
  }
}
