import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/my_bids_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/bid_detail_screen.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/my_bids_item.dart';
import 'package:wastexchange_mobile/widgets/views/error_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class MyBidsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBidsScreenState();

  static const routeName = '/myBidsScreen';
}

class _MyBidsScreenState extends State<MyBidsScreen> {
  MyBidsBloc _bloc;

  @override
  void initState() {
    _bloc = MyBidsBloc();
    _bloc.myBidsStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {});
          break;
      }
    });
    _bloc.myBids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar(
            text: Constants.MY_BIDS,
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: _bloc.bidCount() == 0
            ? ErrorView(message: Constants.NO_BID_ERROR_MESSAGE)
            : ListView.builder(
                itemCount: _bloc.bidCount(),
                itemBuilder: (context, index) {
                  final Bid bid = _bloc.bidAtIndex(index);
                  final User user = _bloc.user(id: bid.sellerId);
                  return MyBidsItem(bid: bid, seller: user, onPressed: () {
                        goToBidDetailPage(bid);
                  });
                },
              ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void goToBidDetailPage(Bid bid) {
    Router.pushNamed(context, BidDetailScreen.routeName,
        arguments: bid);
  }
}
