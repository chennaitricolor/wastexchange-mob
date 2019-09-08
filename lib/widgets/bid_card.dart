import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

import 'commons/card_view.dart';

class BidCard extends StatelessWidget {
  const BidCard(this._bid);

  final Bid _bid;

  @override
  Widget build(BuildContext context) {
    return CardView(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: _getStatusColor(_bid.status),
                child: _getStatus(_bid.status),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Seller: ' + _bid.sellerId,
                            style: AppTheme.title,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Order number: ' + _bid.orderId),
                          Text(
                            'Amount: ' + _bid.amount.toString(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: <Widget>[
                          Text('Order date: ' +
                              _getFormattedDate(_bid.createdDate)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Pickup Date: ' +
                              _getFormattedDate(_bid.pickupDate)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//helpers
  String _getFormattedDate(DateTime date) {
    final f = DateFormat('dd MMM yy h:mm a');
    return f.format(date).toString();
  }

  Widget _getStatus(BidStatus bidStatus) {
    switch (bidStatus) {
      case BidStatus.pending:
        return Icon(
          Icons.timelapse,
        );
      case BidStatus.cancelled:
        return Icon(
          Icons.cancel,
        );
      case BidStatus.successful:
        return Icon(
          Icons.check_circle,
        );
      default:
        return null;
    }
  }

  MaterialColor _getStatusColor(BidStatus status) {
    switch (status) {
      case BidStatus.pending:
        return Colors.yellow;
      case BidStatus.cancelled:
        return Colors.red;
      case BidStatus.successful:
        return Colors.green;
      default:
        return null;
    }
  }
}
