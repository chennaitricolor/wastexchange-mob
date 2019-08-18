import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';

class LoadingProgressIndicator extends StatelessWidget {
  LoadingProgressIndicator({this.alignment = Alignment.center}) {
    alignment = alignment ?? Alignment.center;
  }

  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
          strokeWidth: 3),
    );
  }
}
