import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class ButtonViewCompact extends StatelessWidget {
  const ButtonViewCompact(
      {@required this.onPressed,
      this.text,
      this.width = 160,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RaisedButton(
          color: enabled ? AppColors.green : AppColors.grey,
          child: Text(
            text,
            style: AppTheme.buttonTitle,
          ),
          onPressed: enabled ? onPressed : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0))),
    );
  }

  final VoidCallback onPressed;
  final String text;
  final double width;
  final bool enabled;
}
