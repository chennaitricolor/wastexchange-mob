import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({Key key})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            key: key,
            centerTitle: true,
            title: Text(Constants.APP_TITLE,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.text_black,
                    fontSize: 20)),
            leading: Image.asset(
              Constants.LOGO_SMART_CITY,
              height: 64,
            ));
}
