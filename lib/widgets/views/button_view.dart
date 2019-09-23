import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/custom_button.dart';
import 'package:flutter/material.dart';

class ButtonView extends CustomButton {
  ButtonView(
      {@required text,
      @required onButtonPressed,
      double insetL = 24.0,
      double insetT = 24.0,
      double insetR = 24.0,
      double insetB = 24.0,
      buttonStyle = ButtonStyle.DEFAULT})
      : super(
            buttonText: text,
            onButtonPressed: onButtonPressed,
            margin: EdgeInsets.fromLTRB(insetL, insetT, insetR, insetB),
            buttonStyle: buttonStyle);
}
