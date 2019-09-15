import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/map_bloc.dart';
import 'package:wastexchange_mobile/blocs/my_bids_bloc.dart';
import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_bid_data.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/seller_bid_controller_screen.dart';
import 'package:wastexchange_mobile/screens/seller_bid_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/bid_card.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class MyBidsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBidsScreenState();

  static const routeName = '/myBidsScreen';
}

class _MyBidsScreenState extends State<MyBidsScreen> {
  MyBidsBloc _bidBloc;

  @override
  void initState() {
    _bidBloc = MyBidsBloc();
    _bidBloc.myBidsStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          print(_snapshot.message);
          dismissDialog(context);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {});
          break;
      }
    });
    _bidBloc.myBids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.chrome_grey,
        appBar: HomeAppBar(
            text: Constants.MY_BIDS,
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: _bidBloc.bidCount() == 0
              ? Center(child: Text(Constants.NO_BIDS))
              : ListView.builder(
                  itemCount: _bidBloc.bidCount(),
                  itemBuilder: (itemContext, index) {
                    final Bid bid = _bidBloc.bidAtIndex(index);
                    return BidCard(bid, _bidBloc.user(id: bid.sellerId), () {
                      goToBitDetailPage(bid);
                    });
                  },
                ),
        ));
  }

  @override
  void dispose() {
    _bidBloc.dispose();
    super.dispose();
  }

  void goToBitDetailPage(Bid bid) {
    Router.pushNamed(context, SellerBidController.routeName,
        arguments: bid);
  }
}
