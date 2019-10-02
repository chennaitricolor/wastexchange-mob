import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';

class BidStatusIconView extends StatelessWidget {

  BidStatusIconView({this.bidStatus, this.iconSize});

  final BidStatus bidStatus;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
      switch (bidStatus) {
        case BidStatus.pending:
          return BidStatusIcon(backgroundColor: Colors.yellow.shade700, icon: Icons.timer);
        case BidStatus.cancelled:
          return BidStatusIcon(backgroundColor: Colors.red.shade300, icon: Icons.clear);
        case BidStatus.successful:
          return BidStatusIcon(backgroundColor: Colors.green.shade300, icon: Icons.check);
        default:
          return null;
      }
    }
}

class BidStatusIcon extends StatelessWidget {

  BidStatusIcon({this.icon, this.backgroundColor});

  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final double size = 24;
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