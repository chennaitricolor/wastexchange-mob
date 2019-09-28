import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';

class MyBidsItem extends StatelessWidget {
  const MyBidsItem(this._bid, this._seller);

  final Bid _bid;
  final User _seller;

  @override
  Widget build(BuildContext context) {
    return CardView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            _getStatus(_bid.status),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_seller.name, style: AppTheme.body2),
                  const SizedBox(height: 4),
                  Text(
                    Constants.INR_UNICODE + _bid.amount,
                    style: AppTheme.title,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Constants.PICKUP_AT + _getFormattedDate(_bid.pickupDate),
                    style: AppTheme.body3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//helpers
  String _getFormattedDate(DateTime date) {
    final f = DateFormat(
        '${AppDateFormat.defaultDate} - ${AppDateFormat.defaultTime}');
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
