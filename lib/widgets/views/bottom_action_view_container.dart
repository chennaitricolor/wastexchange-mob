import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class BottomActionViewContainer extends StatelessWidget {

  BottomActionViewContainer({@required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.white),
        height: 90,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children));
  }
}