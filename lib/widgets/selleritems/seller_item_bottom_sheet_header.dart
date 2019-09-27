import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/rectangle_button_view.dart';

class SellerItemBottomSheetHeader extends StatelessWidget {
  const SellerItemBottomSheetHeader(
      {@required this.onPressed,
      @required this.name,
      @required this.isAuthorized,
      @required this.hasItems});

  final VoidCallback onPressed;
  final String name;
  final bool isAuthorized;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final buttonTitle =
        isAuthorized ? Constants.BID_TO_BUY : Constants.LOGIN_TO_BUY;
    // TODO(Sayeed): Fix this
    final buttonEnabled = isAuthorized ? hasItems : true;
    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              name,
              style: AppTheme.body1,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          RectangleButtonView(
            title: buttonTitle,
            onPressed: onPressed,
            enabled: buttonEnabled,
          )
        ],
      ),
    );
  }
}
