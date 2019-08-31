import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/track_bids_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/widgets/bid_card.dart';
import 'package:wastexchange_mobile/models/result.dart';

class TrackBidsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrackBidsScreenState();

  static const routeName = '/trackBidsScreen';
}

class _TrackBidsScreenState extends State<TrackBidsScreen> {
  TrackBidsBloc _bloc;
  //todo
  final _bids = [
    Bid(
        orderId: '123fgh47',
        createdDate: DateTime(2019, 08, 10, 9, 21),
        sellerId: 'PK Steels',
        amount: 109.50,
        pickupDate: DateTime(2019, 09, 02, 5, 30),
        status: BidStatus.pending,
        contactName: 'Azhagu',
        bidItems: []),
    Bid(
        orderId: '2647jfj4',
        createdDate: DateTime(2019, 08, 11, 11, 10),
        sellerId: 'JK Plastics',
        amount: 109.50,
        pickupDate: DateTime(2019, 09, 02, 3, 45),
        status: BidStatus.cancelled,
        contactName: 'Azhagu',
        bidItems: []),
    Bid(
        orderId: '2647jfj4',
        createdDate: DateTime(2019, 08, 11, 17, 19),
        sellerId: 'JK Plastics',
        amount: 109.50,
        pickupDate: DateTime(2019, 09, 01, 21, 20),
        status: BidStatus.successful,
        contactName: 'Azhagu',
        bidItems: []),
  ];

  @override
  void initState() {
    _bloc = TrackBidsBloc();
    _bloc.trackBidsStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          break;
        case Status.ERROR:
          break;
        case Status.COMPLETED:
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.chrome_grey,
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
