import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';

class PrimarySecondaryAction extends StatelessWidget {

  PrimarySecondaryAction({this.primaryBtnText, this.secondaryBtnText, this.actionCallback}) {
    ArgumentError.checkNotNull(primaryBtnText);
    ArgumentError.checkNotNull(secondaryBtnText);
    ArgumentError.checkNotNull(actionCallback);
  }

  final String primaryBtnText;
  final String secondaryBtnText;
  final Function(int action) actionCallback;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ButtonView(
          onButtonPressed: () {
            actionCallback(-1);
          },
          buttonStyle: getSmallButtonStyle(),
          text: secondaryBtnText),
      ButtonView(
          onButtonPressed: () {
            actionCallback(1);
          },
          buttonStyle: getSmallButtonStyle(),
          text: primaryBtnText)
    ]);
  }

}
