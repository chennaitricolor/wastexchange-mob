import 'package:flutter/material.dart';

class NumberTextField extends TextField {

  NumberTextField({this.textEditingController, this.hintText}) : super(
    controller: textEditingController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: hintText,
    ),
  );

  final String hintText;
  final TextEditingController textEditingController;
}