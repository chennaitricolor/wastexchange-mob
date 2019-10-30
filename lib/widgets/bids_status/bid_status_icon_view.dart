import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/widgets/bids_status/bid_status_colors.dart';

class BidStatusIconView extends StatelessWidget {
  const BidStatusIconView({this.bidStatus, this.iconSize});

  final BidStatus bidStatus;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    switch (bidStatus) {
      case BidStatus.PENDING:
        return BidStatusIcon(
            backgroundColor: statusPendingColor, icon: Icons.timer);
      case BidStatus.CANCELLED:
        return BidStatusIcon(
            backgroundColor: statusCancelledColor, icon: Icons.clear);
      case BidStatus.APPROVED:
        return BidStatusIcon(
            backgroundColor: statusCompletedColor, icon: Icons.check);
      default:
        return null;
    }
  }
}

class BidStatusIcon extends StatelessWidget {
  const BidStatusIcon({this.icon, this.backgroundColor});

  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    const double size = 14;
    return CircleAvatar(
      radius: size,
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
