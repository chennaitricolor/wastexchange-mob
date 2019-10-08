import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/buyer_bid_confirmation_bloc.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_screen_launch_data.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/bid_successful_screen.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/connectivity_flushbar_event.dart';
import 'package:wastexchange_mobile/widgets/order_form_header.dart';
import 'package:wastexchange_mobile/widgets/order_form_summary_list.dart';
import 'package:wastexchange_mobile/widgets/order_form_total.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:wastexchange_mobile/widgets/widget_display_util.dart';

class BuyerBidConfirmationScreen extends StatefulWidget {
  factory BuyerBidConfirmationScreen(
      {@required BuyerBidConfirmationScreenLaunchData data}) {
    return BuyerBidConfirmationScreen._(
        seller: data.seller,
        bidItems: data.bidItems,
        isEditBid: data.isEditBid,
        orderId: data.orderId,
        pickupInfoData: data.pickupInfoData,
        onBackPressed: data.onBackPressed);
  }

  const BuyerBidConfirmationScreen._({
    @required User seller,
    @required List<BidItem> bidItems,
    @required bool isEditBid,
    int orderId,
    PickupInfoData pickupInfoData,
    VoidCallback onBackPressed,
  })  : _seller = seller,
        _bidItems = bidItems,
        _isEditBid = isEditBid,
        _orderId = orderId,
        _pickupInfoData = pickupInfoData,
        _onBackPressed = onBackPressed;

  final User _seller;
  final List<BidItem> _bidItems;
  final VoidCallback _onBackPressed;
  final PickupInfoData _pickupInfoData;
  final bool _isEditBid;
  final int _orderId;

  static const String routeName = '/buyerBidConfirmationScreen';

  @override
  _BuyerBidConfirmationScreenState createState() =>
      _BuyerBidConfirmationScreenState();
}

class _BuyerBidConfirmationScreenState
    extends State<BuyerBidConfirmationScreen> {
  BuyerBidConfirmationBloc _bloc;
  final ConnectivityFlushbar _connectivityFlushbar = ConnectivityFlushbar();

  // TODO(Sayeed): Check if this is a design problem that we are having to call a child widget method from parent.
  //Also due to this OrderFormHeaderState is public
  final GlobalKey<OrderFormHeaderState> _keyOrderPickup = GlobalKey();

  void _showMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: const Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  @override
  void initState() {
    _bloc = BuyerBidConfirmationBloc(
        items: widget._bidItems,
        sellerId: widget._seller.id,
        isEditBid: widget._isEditBid,
        orderId: widget._orderId);
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

    _connectivityFlushbar.init(context);

    super.initState();
  }

  void _validateAndPlaceBid() {
    final result = _keyOrderPickup.currentState.pickupInfoData();
    if (result.status == Status.ERROR) {
      _showMessage(result.message);
      return;
    }
    showConfirmationDialog(context, 'Place Bid',
        'You are about to place a bid.\nContinue?', 'Yes', 'No', (status) {
      if (status) {
        _bloc.submitBid(result.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        text: Constants.TITLE_ORDER_FORM,
        onBackPressed: () {
          _keyOrderPickup.currentState.clearSavedData();
          _keyOrderPickup.currentState.saveData();
          if (isNotNull(widget._onBackPressed)) {
            widget._onBackPressed();
          }
          Navigator.pop(context, false);
        },
      ),
      bottomNavigationBar: OrderFormTotal(
        total: _bloc.bidTotal,
        itemsCount: _bloc.items.length,
        onPressed: () {
          _validateAndPlaceBid();
        },
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          OrderFormHeader(
            key: _keyOrderPickup,
            pickupInfoData: widget._pickupInfoData,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: const Text('Order Summary', style: AppTheme.title)),
          OrderFormSummaryList(items: _bloc.items),
        ],
      )),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    _connectivityFlushbar.dispose();
    super.dispose();
  }
}
