import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/core/utils/app_theme.dart';

class AppIntroMessage extends StatelessWidget {
  const AppIntroMessage(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: AppTheme.subtitle,
      ),
    );
  }
}
