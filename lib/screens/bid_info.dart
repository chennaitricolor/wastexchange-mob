import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/widgets/bids_status/bid_status_icon.dart';
import 'package:wastexchange_mobile/widgets/bids_status/bid_status_text.dart';
import 'package:wastexchange_mobile/widgets/tappable_card.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class BidInfo extends StatelessWidget {
  const BidInfo({this.bid});

  final Bid bid;

  @override
  Widget build(BuildContext context) {
    return CardView(
        child: Column(
      children: <Widget>[
        ListTile(
            leading: CircleAvatar(child: Text(bid.amount)),
            title: Text(bid.contactName),
            subtitle: BidStatusText(bidStatus: bid.status),
            trailing: BidStatusIcon(bidStatus: bid.status, iconSize: 16)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.date_range),
                  label: Text(bid.createdDate.toIso8601String())),
              FlatButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.date_range),
                  label: Text(bid.pickupDate.toIso8601String())),
            ],
          ),
        )
      ],
    ));
  }
}
