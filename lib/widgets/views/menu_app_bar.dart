import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

class MenuAppBar extends AppBar {
  MenuAppBar({this.actionItems, this.text})
      : super(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Padding(
                child: Image.asset('assets/images/logo_corporation.png',
                    width: 36, height: 44),
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              )
            ],
            centerTitle: true,
            title: Text(
              text ?? Constants.APP_TITLE,
              style: AppTheme.menuHeader,
            ));
  final List<Widget> actionItems;
  final String text;
}
