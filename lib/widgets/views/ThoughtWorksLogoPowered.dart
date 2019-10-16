import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class ThoughtWorksLogoPowered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(24),
      child: RichText(
          text: TextSpan(
              text: 'Powered by ',
              style: AppTheme.subtitle,
              children: <TextSpan>[
                TextSpan(text: 'Thought', style: AppTheme.thoughtWorksDark),
                TextSpan(text: 'Works', style: AppTheme.thoughtWorksLight),
              ])),
    );
  }
}