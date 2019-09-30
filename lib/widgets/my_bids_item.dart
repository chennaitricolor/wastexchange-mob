import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/bids_status/bid_status_icon.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class MyBidsItem extends StatelessWidget {
  final GestureTapCallback onPressed;
  const MyBidsItem({@required this.onPressed, this.bid, this.seller});

  final Bid bid;
  final User seller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CardView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              BidStatusIcon(bidStatus: bid.status),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(seller.name, style: AppTheme.body2),
                    const SizedBox(height: 4),
                    Text(
                      Constants.INR_UNICODE + bid.amount,
                      style: AppTheme.title,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Constants.PICKUP_AT +
                          _getFormattedDate(bid.pickupDate),
                      style: AppTheme.body3,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//helpers
  String _getFormattedDate(DateTime date) {
    final f =
        DateFormat('${AppDateFormat.shortDate} ${AppDateFormat.defaultTime}');
    return f.format(date.toLocal());
  }
  }
