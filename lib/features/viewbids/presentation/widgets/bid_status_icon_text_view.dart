import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/features/viewbids/presentation/widgets/bid_status_colors.dart';
import 'package:wastexchange_mobile/core/widgets/badge_view.dart';

class BidStatusIconTextView extends StatelessWidget {
  const BidStatusIconTextView({this.bidStatus});
  final BidStatus bidStatus;

  @override
  Widget build(BuildContext context) {
    switch (bidStatus) {
      case BidStatus.pending:
        return BadgeView(
            color: statusPendingColor, text: 'Pending', icon: Icons.timer);
      case BidStatus.cancelled:
        return BadgeView(
            color: statusCancelledColor, text: 'Cancelled', icon: Icons.clear);
      case BidStatus.approved:
        return BadgeView(
            color: statusCompletedColor, text: 'Completed', icon: Icons.check);
      default:
        return null;
    }
  }
}
