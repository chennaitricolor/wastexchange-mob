import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';

class LoadingProgressIndictor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        color: Colors.black54,
        child: Container(alignment: Alignment.center, width: 36, height: 36, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),strokeWidth: 3)),
    ));
  }
}