import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

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
        Constants.LOGIN_TO_BUY,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
