import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class ErrorThumbnail extends StatelessWidget {
  
  ErrorThumbnail({this.message, this.iconPath}) : assert(isNotNull(message), 'Error message should not be null'),
                                                  assert(isNotNull(iconPath), 'Icon path should not be null');
  final String message;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconPath, height: 240, width: 240),
            Text(message, textAlign: TextAlign.center, style: AppTheme.errorThumbnail)
          ],
        ),
      ),
    );
  }
}
