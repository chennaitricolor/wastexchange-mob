import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/login_to_buy_button.dart';

class SellerItemBottomSheetHeader extends StatelessWidget {
  const SellerItemBottomSheetHeader({
    @required this.onPressed,
    this.name,
  });

  final VoidCallback onPressed;
  final String name;

  @override
  Widget build(BuildContext context) {
    final buttonTitle = TokenRepository().isAuthorized()
        ? Constants.BID_TO_BUY
        : Constants.LOGIN_TO_BUY;
    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
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
          const SizedBox(
            width: 10,
          ),
          LoginToBuyButton(
            title: buttonTitle,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
