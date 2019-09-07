import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class MenuAppBar extends AppBar {
  MenuAppBar({this.actionItems, this.text})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              text ?? Constants.APP_TITLE,
              style: AppTheme.headline,
            ));
  final List<Widget> actionItems;
  final String text;
}
