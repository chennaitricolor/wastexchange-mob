import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class ButtonViewCompact extends StatelessWidget {

  ButtonViewCompact({@required this.onPressed, this.text});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: RaisedButton(
          color: AppColors.green,
          child: Text(
            text,
            style: AppTheme.buttonTitle,
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0))),
    );
  }
  VoidCallback onPressed;
  String text;
}