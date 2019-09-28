import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class TappableCard extends StatelessWidget {
  TappableCard(
      {@required this.onPressed,
      @required this.displayText,
      this.iconData,
      this.actionText}) {
    if (isNull(displayText)) {
      throw Exception('displayText cannot be null');
    }
    if (isNull(onPressed)) {
      throw Exception('onPressed cannot be null');
    }
  }

  final VoidCallback onPressed;
  final IconData iconData;
  final String displayText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton.icon(
              padding: const EdgeInsets.all(0),
              onPressed: null,
              icon: Icon(
                iconData,
                size: 16,
                color: AppTheme.darkText,
              ),
              label: Text(
                ' $displayText',
                style: AppTheme.subtitle,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Text(
                '$actionText',
                style: AppTheme.subtitleGreen,
              ))
        ],
      ),
    );
  }
}
