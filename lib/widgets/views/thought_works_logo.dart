import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class ThoughtWorksLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
//            text: 'Powered by ',
//            style: AppTheme.subtitle,
            children: <TextSpan>[
              TextSpan(text: 'Thought', style: AppTheme.title),
              TextSpan(text: 'Works', style: AppTheme.titleLight),
            ]));
  }
}