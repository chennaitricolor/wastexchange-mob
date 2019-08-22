import 'package:flutter/material.dart';

import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class SellerDetailHeaderNoDetail extends StatelessWidget {
  const SellerDetailHeaderNoDetail({@required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ButtonView(
          onButtonPressed: onPressed,
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
          child: Text(
            Constants.ANNOUNCEMENT_MESSAGE,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Text(
            Constants.USER_ENCOURAGE_LOGIN_MESSAGE,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}
