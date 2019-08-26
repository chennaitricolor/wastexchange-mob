import 'package:flutter/material.dart';

import 'package:wastexchange_mobile/utils/constants.dart';

class AnnouncementMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.ANNOUNCEMENT_MESSAGE,
      style: const TextStyle(
        fontSize: 25.0,
      ),
    );
  }
}
