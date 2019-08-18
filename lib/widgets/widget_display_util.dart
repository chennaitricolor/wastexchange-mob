import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/error_dialog.dart';
import 'package:wastexchange_mobile/widgets/backdrop_loading_indicator.dart';

class DisplayUtil {

  DisplayUtil._privateConstructor();

  static final DisplayUtil _instance = DisplayUtil._privateConstructor();

  static DisplayUtil get instance { return _instance;}

  void showLoadingDialog(BuildContext buildContext) {
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return BackdropLoadingProgressIndicator();
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
}