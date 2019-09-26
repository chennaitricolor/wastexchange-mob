import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class BelowAppBarMessage extends StatelessWidget {

  BelowAppBarMessage({this.message});

  String message;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            width: double.infinity,
            color: AppColors.chrome_grey,
            child: Text(message ?? '', style: AppTheme.subtitle)));
  }
}
