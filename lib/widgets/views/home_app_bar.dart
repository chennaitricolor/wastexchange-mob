import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({Key key, this.actionItems, this.text})
      : super(
          backgroundColor: Colors.transparent,
          elevation: 0,
          key: key,
          centerTitle: true,
          actions: _actionItems(actionItems),
          title: Text(
            text ?? Constants.APP_TITLE,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.text_black,
                fontSize: 20),
          ),
          leading: Image.asset(
            Constants.LOGO_SMART_CITY,
            height: 64,
          ),
        );
  final List<Widget> actionItems;
  final String text;

  static Widget _indianEmblem() => Image.asset(
        Constants.INDIAN_EMBLEM,
        height: 64,
      );

  static List<Widget> _actionItems(List<Widget> actionItems) {
    final totalItems = actionItems ?? <Widget>[];
    totalItems.add(_indianEmblem());
    return totalItems;
  }
}
