import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class ButtonView extends CustomButton {
  ButtonView(
      {@required text,
      @required onButtonPressed,
      double insetL = 24.0,
      double insetT = 24.0,
      double insetR = 24.0,
      double insetB = 24.0})
      : super(
            textStyle: AppTheme.buttonTitle,
            buttonText: text,
            onButtonPressed: onButtonPressed,
            margin: EdgeInsets.fromLTRB(insetL, insetT, insetR, insetB),
            buttonStyle: ButtonStyle.value(240, 55, 55, AppColors.green, Colors.white));
}
