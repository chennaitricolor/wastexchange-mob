import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class BottomActionViewContainer extends StatelessWidget {

  BottomActionViewContainer({@required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: AppColors.white),
        height: 90,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children));
  }
}