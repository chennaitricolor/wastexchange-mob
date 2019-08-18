import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/widgets/loading_progress_indicator.dart';

class BackdropLoadingProgressIndicator extends StatelessWidget {
  BackdropLoadingProgressIndicator({this.alignment, this.width, this.height});

  Alignment alignment = Alignment.center;
  double width = 36.0;
  double height = 36.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        color: Colors.black54,
        child: Container(
          alignment: alignment,
          width: width,
          height: height,
          child: LoadingProgressIndicator(),
        ),
      ),
    );
  }
}
