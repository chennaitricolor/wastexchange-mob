import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/widgets/views/bid_status_icon.dart';

class BidInfo extends StatelessWidget {
  const BidInfo(
      {this.bid});

  final Bid bid;

  @override
  Widget build(BuildContext context) {
    print("bid info view");
    return Card(
        child: Padding(padding: EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              getAddressView(),
              Row(children: <Widget>[getBidIdView(), getBidStatusView()]),
              getBidDateAndTime(),
              Row(children: <Widget>[],),
              Row(children: <Widget>[getContactPersonView(), getAmountView()],),
              getPickupDateAndTime()
            ],))
    );
  }

  Widget getAddressView() {
    return Text("Pallikaranai, Chennai");
  }

  Widget getBidStatusView() {
    return Row(children: <Widget>[BidStatusIcon(bidStatus: bid.status, iconSize: 16), _getStatusText(bid.status)],);
  }

  Widget getBidIdView() {
    return Text('${bid.status.toString()}');
  }

  Widget _getStatusIcon(BidStatus bidStatus) {
    switch (bidStatus) {
      case BidStatus.pending:
        return Icon(
          Icons.timelapse,
          size: 16,
          color: Colors.yellow.shade700,
        );
      case BidStatus.cancelled:
        return Icon(
          Icons.cancel,
          size: 16,
          color: Colors.red.shade300,
        );
      case BidStatus.successful:
        return Icon(
          Icons.check_circle,
          size: 16,
          color: Colors.green.shade300,
        );
      default:
        return null;
    }
  }

  Widget _getStatusText(BidStatus bidStatus) {
    switch (bidStatus) {
      case BidStatus.pending:
        return Text(
          'Pending'
        );
      case BidStatus.cancelled:
        return Text(
          'Cancelled'
        );
      case BidStatus.successful:
        return Text(
          'Success'
        );
      default:
        return null;
    }
  }

  Widget getBidDateAndTime() {
    return Text('Bid Date : ${bid.createdDate.toIso8601String()}');
  }

  Widget getContactPersonView() {
    return Column(children: <Widget>[
      Text('Contact Person'),
      Text(bid.contactName)
    ]);
  }

  Widget getAmountView() {
    return Column(children: <Widget>[
      Text('Amount'),
      Text(bid.amount)
    ]);
  }

  Widget getPickupDateAndTime() {
    return Text('Pickup : ${bid.pickupDate.toIso8601String()}');
  }
}
