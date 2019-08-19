import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';

class LoginToBuyButton extends StatelessWidget {
  const LoginToBuyButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: AppColors.green,
      child: const Text(
        'Login to buy',
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}