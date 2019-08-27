import 'package:flutter/material.dart';

import 'package:wastexchange_mobile/utils/constants.dart';

class AnnouncementMessage extends StatelessWidget {

  AnnouncementMessage(this.text);
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
