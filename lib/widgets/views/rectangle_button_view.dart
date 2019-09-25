import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class RectangleButtonView extends StatelessWidget {
  const RectangleButtonView(
      {Key key,
      @required this.onPressed,
      @required this.title,
      this.enabled = true})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: enabled ? AppColors.green : AppColors.grey,
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      onPressed: enabled ? onPressed : null,
    );
  }
}
