import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/bids_status/bid_status_icon_text_view.dart';
import 'package:wastexchange_mobile/widgets/calendar_card_widget.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class BidDetailsHeader extends StatelessWidget {
  const BidDetailsHeader({this.bid, this.user});

  final Bid bid;
  final User user;

  @override
  Widget build(BuildContext context) {
    final address = user?.address ?? EMPTY;
    return CardView(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(
                child: Visibility(
                    visible: !isNullOrEmpty(address),
                    child: Text(address, style: AppTheme.body2))),
            const SizedBox(width: 8),
            Container(
                child: BidStatusIconTextView(bidStatus: bid.status), width: 100)
          ]),
          Container(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(
              child: Row(children: <Widget>[
                Icon(
                  Icons.person,
                  size: 18,
                  color: AppTheme.lightText,
                ),
                const SizedBox(width: 5),
                Flexible(
                    child: Text(bid.contactName, style: AppTheme.subtitle)),
              ]),
            ),
            const SizedBox(width: 8),
            Container(
                alignment: Alignment.centerRight,
                child: Text('${formattedPrice(bid.amount)}',
                    style: AppTheme.title),
                width: 85)
          ]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CalendarCardWidget(hint: 'Created date', date: bid.createdDate),
              Icon(Icons.date_range, color: AppTheme.lightText),
              CalendarCardWidget(hint: 'Pickup date', date: bid.pickupDate),
            ],
          )
        ],
      ),
    ));
  }
}
