import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class HomeAppBar extends AppBar {
  HomeAppBar(
      {Key key,
      this.actionItems,
      this.text,
      @required this.onBackPressed,
      this.showBack = true})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            key: key,
            centerTitle: true,
            actions: _actionItems(actionItems),
            title: Text(
              text ?? Constants.APP_TITLE,
              style: AppTheme.headline,
            ),
            leading: showBack
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: AppTheme.dark_grey),
                    onPressed: onBackPressed,
                  )
                : null);
  final List<Widget> actionItems;
  final VoidCallback onBackPressed;
  final String text;
  final bool showBack;

  static Widget _defaultActionItem() => Image.asset(
        Constants.LOGO_SMART_CITY,
        height: 32,
      );

  static List<Widget> _actionItems(List<Widget> actionItems) {
    final totalItems = actionItems ?? <Widget>[];
    totalItems.add(_defaultActionItem());
    return totalItems;
  }
}
