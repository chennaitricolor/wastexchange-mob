import 'package:authentication_view/auth_colors.dart';
import 'package:authentication_view/button_style.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/dialogs/error_dialog.dart';
import 'package:wastexchange_mobile/widgets/dialogs/loading_dialog.dart';
import 'package:wastexchange_mobile/widgets/views/error_thumbnail.dart';

  void showLoadingDialog(BuildContext buildContext) {
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return Material(type: MaterialType.transparency, child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 60),
          child: ErrorThumbnail(message: Constants.LOADING_MESSAGE, iconPath: Constants.LOADING_ICON,),
        ));
      },
    );
  }

  void showErrorDialog(BuildContext buildContext, String message) {
    showDialog(
      barrierDismissible: true,
      context: buildContext,
      builder: (BuildContext context) {
        return ErrorDialog(message);
      },
    );
  }

  void dismissDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

void showConfirmationDialog(BuildContext context, String title, String content, positiveBtnText, negativeBtnText, Function confirmCallback) {
  // flutter defined function

  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          FlatButton(
            child: Text(negativeBtnText),
            onPressed: () {
              Navigator.of(context).pop();
              confirmCallback(false);
            },
          ),
          FlatButton(
            child: Text(positiveBtnText),
            onPressed: () {
              Navigator.of(context).pop();
              confirmCallback(true);
            },
          )
        ],
      );
    }
  );
}