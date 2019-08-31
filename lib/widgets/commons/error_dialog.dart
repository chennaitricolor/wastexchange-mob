import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/widget_display_util.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            dismissDialog(context);
          },
          child: Container(
            width: double.infinity,
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                  child: Text(message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18))),
            ),
          ),
        ));
  }
}
