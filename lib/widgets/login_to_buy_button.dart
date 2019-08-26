import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class LoginToBuyButton extends StatelessWidget {
  const LoginToBuyButton({
    Key key,
    @required this.onPressed,
    @required this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: AppColors.green,
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
