import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class TappableCard extends StatelessWidget {
  TappableCard(
      {@required this.onPressed,
      @required this.displayText,
      this.iconData,
      this.actionText}) {
    if (isNull(displayText)) {
      throw Exception('displayText cannot be null');
    }
    if (isNull(onPressed)) {
      throw Exception('onPressed cannot be null');
    }
  }
  final VoidCallback onPressed;
  final IconData iconData;
  final String displayText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0,
      onPressed: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: 44.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        iconData,
                        size: 20.0,
                        color: AppColors.green,
                      ),
                      Text(
                        ' $displayText',
                        style: const TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              '$actionText',
              style: const TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
