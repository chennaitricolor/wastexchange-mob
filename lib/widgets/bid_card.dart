import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

import 'commons/card_view.dart';

class BidCard extends StatelessWidget {
  const BidCard(this._bid, this._seller, this.callback);

  final Bid _bid;
  final User _seller;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return CardView(
    child: InkWell(
      onTap: () {
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _getStatus(_bid.status),
                )),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(_seller.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        Constants.RUPEE + _bid.amount,
                        style: AppTheme.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        Constants.PICKUP_AT +
                            _getFormattedDate(_bid.pickupDate),
                        style: AppTheme.body3,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

//helpers
  String _getFormattedDate(DateTime date) {
    final f = DateFormat('dd MMM h:mm a');
    return f.format(date.toLocal());
  }

  Widget _getStatus(BidStatus bidStatus) {
    switch (bidStatus) {
      case BidStatus.pending:
        return Icon(
          Icons.timelapse,
          size: 36,
          color: Colors.yellow.shade700,
        );
      case BidStatus.cancelled:
        return Icon(
          Icons.cancel,
          size: 36,
          color: Colors.red.shade300,
        );
      case BidStatus.successful:
        return Icon(
          Icons.check_circle,
          size: 36,
          color: Colors.green.shade300,
        );
      default:
        return null;
    }
  }
}
