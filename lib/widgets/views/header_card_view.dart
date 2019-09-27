import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class HeaderCardView extends Card {
  const HeaderCardView({@required Widget child})
      : super(
            elevation: 1,
            color: AppColors.card_black,
            child: child,
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4));
}
