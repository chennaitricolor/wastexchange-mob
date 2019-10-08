import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class DrawerItemView extends StatelessWidget {

  final VoidCallback onItemPressed;
  final IconData iconData;
  final String text;
  final bool visibility;

  DrawerItemView({@required this.onItemPressed, this.iconData, this.text, this.visibility});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility ?? true,
      child: ListTile(
          leading: Icon(iconData, color: AppTheme.dark_grey.withOpacity(0.8)),
          title: Text(text, style: AppTheme.navigationItem),
          onTap: onItemPressed
      ),
    )
    ;
  }

}