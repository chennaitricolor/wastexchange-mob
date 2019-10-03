import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class ErrorView extends StatelessWidget {

  ErrorView({this.message}) : assert(isNotNull(message), 'Error message should not be null');

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(message, textAlign: TextAlign.center, style: AppTheme.errorThumbnail),
      ),
    );
  }
}
