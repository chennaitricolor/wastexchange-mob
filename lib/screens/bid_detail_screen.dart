import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/bid_detail_bloc.dart';
import 'package:wastexchange_mobile/blocs/map_bloc.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/bid_edit_item_list.dart';
import 'package:wastexchange_mobile/screens/bid_info.dart';
import 'package:wastexchange_mobile/screens/bid_item_list.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/screens/seller_item_list.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class BidDetailScreen extends StatefulWidget {

  BidDetailScreen({this.bid}) {
    ArgumentError.checkNotNull(bid);
  }

  final Bid bid;

  @override
  State<StatefulWidget> createState() => _BidDetailScreenState(bid: bid);

  static const routeName = '/bidDetailScreen';
}

class _BidDetailScreenState extends State<BidDetailScreen> with SellerItemListener {

  _BidDetailScreenState({this.bid});

  BidDetailBloc _bloc;
  MapBloc _mapBloc;
  SellerItemBloc _sellerItemBloc;
  bool isEditMode = false;
  SellerItemDetails sellerItemDetails;
  bool _isCancelOperation = false;
  Bid bid;
  User seller;

  List<TextEditingController> _quantityTextEditingControllers;
  List<TextEditingController> _priceTextEditingControllers;

  @override
  void initState() {
    print(bid.bidItems.values.length);
    _bloc = BidDetailBloc();
    _mapBloc = MapBloc();

    _bloc.sellerStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          print(_snapshot.message);
          dismissDialog(context);
          break;
        case Status.COMPLETED:
          print(_snapshot.data);
          _mapBloc.getAllUsers().then((result) {
            dismissDialog(context);
            setState(() {
              sellerItemDetails = _snapshot.data;
              seller = _mapBloc.getUser(sellerItemDetails.sellerId);
              _sellerItemBloc = SellerItemBloc(this, SellerInfo(seller: seller, items: sellerItemDetails.items));
              _quantityTextEditingControllers =
                  sellerItemDetails.items.map((_) => TextEditingController()).toList();
              _priceTextEditingControllers =
                  sellerItemDetails.items.map((_) => TextEditingController()).toList();
            });
          });
          break;
      }
    });
    _bloc.bidStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          print(_snapshot.message);
          dismissDialog(context);
          if(_isCancelOperation) {
            _isCancelOperation = false;
          }
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {
            if(_isCancelOperation) {
              _isCancelOperation = false;
              bid.status = BidStatus.cancelled;
            }
          });
          break;
      }
    });

    _bloc.getSellerDetails(bid.sellerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(bid);
    print(sellerItemDetails);
    if(bid != null && sellerItemDetails != null) {
      print("showing bid details");
      return showBidDetails();
    } else {
      return emptyView();
    }

  }

  bool isPendingBid() {
    return bid.status == BidStatus.pending;
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget getSubmitAndCancelButtons() {
    return Row(children: <Widget>[
      ButtonView(
          onButtonPressed: () {
            setState(() {
              isEditMode = false;
            });
          },
          buttonStyle: getSmallButtonStyle(),
          text: Constants.BUTTON_CANCEL),
      ButtonView(
          onButtonPressed: () {
            _sellerItemBloc.onSubmitBids(_quantityValues(), _priceValues());
          },
          buttonStyle: getSmallButtonStyle(),
          text: Constants.BUTTON_SUBMIT)
    ]);
  }

  Widget getEditAndCancelBidButtons() {
    return Row(children: <Widget>[
      ButtonView(
        onButtonPressed: () {
          askCancelConfirmation();
        },
        buttonStyle: getSmallButtonStyle(),
        text: Constants.BUTTON_CANCEL_BID,),
      ButtonView(
          onButtonPressed: () {
            setState(() {
              isEditMode = true;
            });
          },
          buttonStyle: getSmallButtonStyle(),
          text: Constants.BUTTON_EDIT_BID)
    ]);
  }

  void askCancelConfirmation() {
    showConfirmationDialog(context, "Cancel Bid", "Are you sure, You want to cancel the bid", "Yes", "No", (status) {
      if(status) {
        _isCancelOperation = true;
        _bloc.cancelBid(bid, sellerItemDetails);
      }
    });
  }

  Widget showBidDetails() {

    return Scaffold(
        bottomNavigationBar: isPendingBid()? isEditMode ? getSubmitAndCancelButtons() : getEditAndCancelBidButtons() : Row(),
        backgroundColor: AppColors.chrome_grey,
        appBar: HomeAppBar(
            text: 'Order Id : ${bid.orderId}',
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: isEditMode? getEditItemView(): getBidItemView()));
  }

  Widget emptyView() {
    return Scaffold(
        backgroundColor: AppColors.chrome_grey,
        appBar: HomeAppBar(
            text: 'Order Id : ${bid.orderId}',
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
        ));
  }

  Widget getEditItemView() {
    return CustomScrollView(slivers: <Widget>[
      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return BidInfo(bid: bid);
      }, childCount: 1)),
      BidEditItemList(
          bidItems: sellerItemDetails.items.map((item) => BidItem(item: item)).toList(),
          quantityEditingControllers: _quantityTextEditingControllers,
          priceEditingControllers: _priceTextEditingControllers)
    ]);
  }

  Widget getBidItemView() {
    print("at bid item view");
    return CustomScrollView(slivers: <Widget>[
      SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return BidInfo(bid: bid);
      }, childCount: 1)),
      BidItemList(bidItems: bid.bidItems.values.map((item) => BidItem(item: item)).toList())
    ]);
  }


  List<String> _quantityValues() => _quantityTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  List<String> _priceValues() => _priceTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  @override
  void onValidationSuccess({Map<String, dynamic> sellerInfo}) {
    Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
        arguments: sellerInfo);
  }

  void showErrorMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  @override
  void onValidationError(String message) {
    showErrorMessage(message);
  }

  @override
  void onValidationEmpty(String message) {
    showErrorMessage(message);
  }
}
