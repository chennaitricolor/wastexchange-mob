import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/views/badge_view.dart';

class BidStatusIconTextView extends StatelessWidget {

  BidStatusIconTextView({this.bidStatus});
  BidStatus bidStatus;

  @override
  Widget build(BuildContext context) {
    switch (bidStatus) {
      case BidStatus.pending:
        return BadgeView(color: Colors.yellow.shade700, text: 'Pending', icon: Icons.timer);
      case BidStatus.cancelled:
        return BadgeView(color: Colors.red.shade300, text: 'Cancelled', icon: Icons.clear);
      case BidStatus.successful:
        return BadgeView(color: Colors.green.shade300, text: 'Success', icon: Icons.check);
      default:
        return null;
    }
  }

}