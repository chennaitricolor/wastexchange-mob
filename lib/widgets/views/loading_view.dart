import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({String message}) : _message = message ?? '';

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            const LoadingProgressIndicator(),
            const SizedBox(height: 16),
            Text(_message, textAlign: TextAlign.center, style: AppTheme.body1)
          ])),
    );
  }
}
