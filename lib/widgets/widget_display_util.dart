import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/commons/error_dialog.dart';
import 'package:wastexchange_mobile/widgets/backdrop_loading_indicator.dart';

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