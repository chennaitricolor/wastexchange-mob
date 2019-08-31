import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class HomeAppBar extends AppBar {
  final List<Widget> actions;
  final String text;

  HomeAppBar({Key key, this.actions, this.text})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            key: key,
            centerTitle: true,
            actions: actions,
            title: Text(text ?? Constants.APP_TITLE,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text_black,
                    fontSize: 20)),
            leading: Image.asset(
              Constants.LOGO_SMART_CITY,
              height: 64,
            ));
}