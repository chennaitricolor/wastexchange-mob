import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/core/utils/app_theme.dart';
import 'package:wastexchange_mobile/core/utils/global_utils.dart';

class EmptyPageView extends StatelessWidget {
  EmptyPageView({String message})
      : assert(isNotNull(message), 'message should not be null'),
        _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child:
            Text(_message, textAlign: TextAlign.center, style: AppTheme.body1),
      ),
    );
  }
}
