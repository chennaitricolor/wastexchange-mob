import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class BadgeView extends StatelessWidget {

  BadgeView({this.color, this.text, this.icon}): assert(isNotNull(color), 'Color field should not be null'), assert(isNotNull(text), 'Text should not be null');

  Color color;
  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.fromLTRB(4, 2, 4, 2), color: color, child: Row(
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 2),
        Text(text, textAlign: TextAlign.left, style: AppTheme.subtitleWhite),
      ],
    ));
  }

}