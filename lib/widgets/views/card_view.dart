import 'package:flutter/material.dart';

class CardView extends Card {
  const CardView({@required Widget child})
      : super(
            elevation: 1,
            child: child,
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4));
}
