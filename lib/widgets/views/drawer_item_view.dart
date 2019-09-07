import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class DrawerItemView extends ListTile {

  DrawerItemView({@required this.onItemPressed, this.iconData, this.text}) :  super (
      leading: Icon(iconData, color: AppTheme.dark_grey.withOpacity(0.8)),
        title: Text(text, style: AppTheme.navigationItem),
  onTap: onItemPressed);

  final VoidCallback onItemPressed;
  final IconData iconData;
  final String text;

}