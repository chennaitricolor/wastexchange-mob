import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/place_bid_bloc.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/bid_successful_screen.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/order_summary.dart';
import 'package:wastexchange_mobile/widgets/order_pickup.dart';
import 'package:wastexchange_mobile/widgets/order_total.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class BuyerBidConfirmationScreen extends StatefulWidget {
  const BuyerBidConfirmationScreen({this.seller, this.bidItems});

  static const String routeName = '/buyerBidConfirmationScreen';

  final User seller;
  final List<BidItem> bidItems;

  @override
  _BuyerBidConfirmationScreenState createState() =>
      _BuyerBidConfirmationScreenState();
}

class _BuyerBidConfirmationScreenState
    extends State<BuyerBidConfirmationScreen> {
  PlaceBidBloc _bloc;
  // TODO(Sayeed): Check if this is a design problem that we are having to call a child widget method from parent.
  final GlobalKey<OrderPickupState> _keyOrderPickup = GlobalKey();

  void _showMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  @override
  void initState() {
    _bloc = PlaceBidBloc(items: widget.bidItems, sellerId: widget.seller.id);
    _bloc.bidStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          _showMessage(Constants.BID_FAILURE_MSG);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          Router.pushNamed(context, BidSuccessfulScreen.routeName);
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        text: Constants.TITLE_ORDER_FORM,
        onBackPressed: () {
          Navigator.pop(context, false);
        },
      ),
      bottomNavigationBar: OrderTotal(
        total: _bloc.bidTotal(),
        itemsCount: widget.bidItems.length,
        onPressed: () {
          final result = _keyOrderPickup.currentState.pickupInfoData();
          if (result.status == Status.ERROR) {
            _showMessage(result.message);
            return;
          }
          _bloc.placeBid(result.data);
        },
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          OrderPickup(key: _keyOrderPickup),
          Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20, bottom: 16),
              child: OrderSummary(items: widget.bidItems)),
        ],
      )),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
