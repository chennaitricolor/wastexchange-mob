import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/widgets/login_to_buy_button.dart';

class SellerDetailHeader extends StatelessWidget {
  const SellerDetailHeader({@required this.onPressed, this.name});

  final VoidCallback onPressed;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColors.text_black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          LoginToBuyButton(
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
