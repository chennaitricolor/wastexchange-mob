import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/my_bids_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/bid_card.dart';

class MyBidsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBidsScreenState();

  static const routeName = '/myBidsScreen';
}

class _MyBidsScreenState extends State<MyBidsScreen> {
  MyBidsBloc _bloc;
  var _bids = [];

  @override
  void initState() {
    _bloc = MyBidsBloc();
    _bloc.myBidsStream.listen((_snapshot) {
      _bids = _snapshot.data;
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {
            _bids = _snapshot.data;
          });
          break;
      }
    });
    _bloc.trackBid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.chrome_grey,
        appBar: AppBar(
          title: const Text(Constants.TRACK_BIDS),
          backgroundColor: AppColors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: _bids.isEmpty
              ? Center(child: const Text(Constants.NO_BIDS))
              : ListView.builder(
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
