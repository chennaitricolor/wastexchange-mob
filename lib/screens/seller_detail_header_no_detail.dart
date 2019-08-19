import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/button_view.dart';
import 'package:flutter/material.dart';

class SellerDetailHeaderNoDetail extends StatelessWidget {

  SellerDetailHeaderNoDetail({@required this.onPressed});

  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ButtonView(
          onButtonPressed: onPressed,
          buttonText: 'Login to buy',
          margin: const EdgeInsets.all(16),
          buttonStyle: ButtonStyle.DEFAULT),
    );
  }
}