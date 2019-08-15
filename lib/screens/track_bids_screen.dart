import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/widgets/bid_card.dart';

class TrackBidsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrackBidsScreenState();
}

class _TrackBidsScreenState extends State<TrackBidsScreen> {
  //todo
  final _bids = [
    Bid('123fgh47', DateTime(2019, 08, 10), 'PK Steels', 109.50,
        DateTime(2019, 09, 02), BidStatus.pending),
    Bid('2647jfj4', DateTime(2019, 08, 11), 'JK Plastics', 200.00,
        DateTime(2019, 09, 02), BidStatus.cancelled),
    Bid('3647hfjd', DateTime(2019, 08, 11), 'RS Steels', 10000.00,
        DateTime(2019, 09, 01), BidStatus.successful),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.green,
        appBar: AppBar(
          title: const Text('Track Bids'),
          backgroundColor: AppColors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: ListView.builder(
            itemCount: _bids.length,
            itemBuilder: (context, index) {
              return BidCard(_bids[index]);
            },
          ),
        ));
  }
}
