import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class ButtonViewIconCompact extends StatelessWidget {
  const ButtonViewIconCompact({@required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
        color: AppColors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
        onPressed: onPressed,
        icon: Icon(
          Icons.check,
          color: Colors.white,
          size: 25,
        ),
        label: Text(
          text,
          style: AppTheme.buttonTitle,
        ));
  }

  final VoidCallback onPressed;
  final String text;
}
