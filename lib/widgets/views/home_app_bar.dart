import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class HomeAppBar extends AppBar {
  HomeAppBar(
      {Key key,
      this.actionItems,
      this.text,
      this.onBackPressed,
      this.showBack = true})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            key: key,
            centerTitle: true,
            title: Text(
              text ?? Constants.APP_TITLE,
              style: AppTheme.headline,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            ));
  final List<Widget> actionItems;
  final VoidCallback onBackPressed;
  final String text;
  final bool showBack;
}
