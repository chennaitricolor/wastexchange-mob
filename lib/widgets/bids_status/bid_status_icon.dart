import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';

class BidStatusIcon extends StatelessWidget {

  BidStatusIcon({this.bidStatus, this.iconSize});

  final BidStatus bidStatus;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final double size = iconSize ?? 36;
      switch (bidStatus) {
        case BidStatus.pending:
          return Icon(
            Icons.timelapse,
            size: size,
            color: Colors.yellow.shade700,
          );
        case BidStatus.cancelled:
          return Icon(
            Icons.cancel,
            size: size,
            color: Colors.red.shade300,
          );
        case BidStatus.successful:
          return Icon(
            Icons.check_circle,
            size: size,
            color: Colors.green.shade300,
          );
        default:
          return null;
      }
    }
}