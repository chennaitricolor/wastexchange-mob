import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/custom_button.dart';
import 'package:flutter/material.dart';

class ButtonView extends CustomButton {
  ButtonView({@required text, @required onButtonPressed, double inset = 24})
      : super(
            buttonText: text,
            onButtonPressed: onButtonPressed,
            margin: EdgeInsets.all(inset),
            buttonStyle: ButtonStyle.DEFAULT);
}
