import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class ErrorView extends StatelessWidget {
  ErrorView({this.message, this.retryCallback})
      : assert(isNotNull(message), 'Error message should not be null');

  final String message;
  final VoidCallback retryCallback;

  @override
  // TODO(Sayeed): Should we wrap this into container like LoadingView
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _widgets())),
    );
  }

  List<Widget> _widgets() {
    final List<Widget> widgets = [];
    if (isNotNull(retryCallback)) {
      final retryButton = FlatButton(
        onPressed: retryCallback,
        child: Icon(
          Icons.replay,
          color: AppTheme.darkerText,
          size: 44.0,
        ),
        shape: CircleBorder(),
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8.0),
      );
      widgets.add(retryButton);
      widgets.add(const SizedBox(height: 16));
    }
    widgets
        .add(Text(message, textAlign: TextAlign.center, style: AppTheme.body1));

    return widgets;
  }
}
