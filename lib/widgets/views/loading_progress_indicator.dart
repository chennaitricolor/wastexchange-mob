import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({this.alignment = Alignment.center});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
          strokeWidth: 3),
    );
  }
}
