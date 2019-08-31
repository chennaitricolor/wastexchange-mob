import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/dialogs/error_dialog.dart';
import 'package:wastexchange_mobile/widgets/dialogs/loading_dialog.dart';

  void showLoadingDialog(BuildContext buildContext) {
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return LoadingDialog();
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