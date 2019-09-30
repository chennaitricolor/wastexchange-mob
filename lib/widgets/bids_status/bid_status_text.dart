import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class BidStatusText extends StatelessWidget {

  BidStatusText({this.bidStatus});
  BidStatus bidStatus;

  @override
  Widget build(BuildContext context) {
    switch (bidStatus) {
      case BidStatus.pending:
        return const Text('Pending', style: AppTheme.statusYellow,);
      case BidStatus.cancelled:
        return const Text('Cancelled', style: AppTheme.statusRed);
      case BidStatus.successful:
        return const Text('Success', style: AppTheme.statusGreen);
      default:
        return null;
    }
  }

}