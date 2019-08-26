import 'package:flutter/material.dart';

import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/announcement_message.dart';
import 'package:wastexchange_mobile/widgets/encourage_login_message.dart';
import 'package:wastexchange_mobile/widgets/tap_seller_for_details.dart';

class SellerDetailHeaderNoDetail extends StatelessWidget {
  const SellerDetailHeaderNoDetail({
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
        Container(
          margin: const EdgeInsets.only(
            top: 10.0,
            left: 16.0,
            right: 16.0,
          ),
          child: AnnouncementMessage(),
        ),
        const SizedBox(
          height: 25.0,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: EncourageLoginMessage(),
        ),
      ],
    );
  }
}
