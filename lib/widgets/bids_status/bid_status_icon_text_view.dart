import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/widgets/bids_status/bid_status_colors.dart';
import 'package:wastexchange_mobile/widgets/views/badge_view.dart';

class BidStatusIconTextView extends StatelessWidget {
  const BidStatusIconTextView({this.bidStatus});
  final BidStatus bidStatus;

  @override
  Widget build(BuildContext context) {
    switch (bidStatus) {
      case BidStatus.PENDING:
        return BadgeView(
            color: statusPendingColor, text: 'Pending', icon: Icons.timer);
      case BidStatus.CANCELLED:
        return BadgeView(
            color: statusCancelledColor, text: 'Cancelled', icon: Icons.clear);
      case BidStatus.APPROVED:
        return BadgeView(
            color: statusCompletedColor, text: 'Completed', icon: Icons.check);
      default:
        return null;
    }
  }
}
