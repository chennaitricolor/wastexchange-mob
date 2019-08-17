import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:intl/intl.dart';

class BidCard extends StatelessWidget {
  const BidCard(this._bid);

  final Bid _bid;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Order number: ' + _bid.orderId),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text('Status: '),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: _getStatus(_bid.status),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Seller: ' + _bid.sellerId),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child:
                    Text('Order date: ' + _getFormattedDate(_bid.createdDate)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('amount: ' + _bid.amount.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child:
                    Text('Pickup Date: ' + _getFormattedDate(_bid.pickupDate)),
              )
            ],
          ),
        ],
      ),
    );
  }

//helpers
  String _getFormattedDate(DateTime date) {
    final f = DateFormat('yyyy-MM-dd h:mm a');
    return f.format(date).toString();
  }

  Icon _getStatus(BidStatus bidStatus) {
    switch (bidStatus) {
      case BidStatus.pending:
        {
          return Icon(
            Icons.access_time,
            color: Colors.yellow,
          );
        }
      case BidStatus.cancelled:
        return Icon(
          Icons.cancel,
          color: Colors.red,
        );
      case BidStatus.successful:
        return Icon(
          Icons.check,
          color: Colors.green,
        );
      default:
        return null;
    }
  }
}
