import 'package:flutter/material.dart';

class NumberErrorTextField extends TextField {

  NumberErrorTextField({this.textEditingController, this.hintText}) : super(
    controller: textEditingController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red)),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      hintText: hintText,
    ),
  );

  final String hintText;
  final TextEditingController textEditingController;
}