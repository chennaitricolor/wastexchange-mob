import 'package:flutter/material.dart';

import 'package:wastexchange_mobile/utils/constants.dart';

class EncourageLoginMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.USER_ENCOURAGE_LOGIN_MESSAGE,
      style: const TextStyle(
        fontSize: 25.0,
      ),
    );
  }
}
