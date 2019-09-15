import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/seller_bid_data.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class SellerBidScreen extends StatefulWidget {
  SellerBidScreen({this.sellerBidData, this.sellerBidFlow}) {
    ArgumentError.checkNotNull(sellerBidData);
    ArgumentError.checkNotNull(sellerBidFlow);
    ArgumentError.checkNotNull(sellerBidData.sellerInfo);
    ArgumentError.checkNotNull(sellerBidData.sellerInfo.seller);
    ArgumentError.checkNotNull(sellerBidData.sellerInfo.items);
    if (sellerBidData.sellerInfo.items.isEmpty) {
      throw Exception('Seller Items is empty');
    }
  }

  final SellerBidData sellerBidData;
  SellerBidFlow sellerBidFlow;

  static const routeName = '/sellerItemScreen';

  
  @override
  _SellerBidScreenState createState() => _SellerBidScreenState();
}

class _SellerBidScreenState extends State<SellerBidScreen>
    with SellerItemListener {


  final _formKey = GlobalKey<FormState>();
  final logger = AppLogger.get('SellerInformationScreen');
  Map<int, List<int>> validationMap = {};
  SellerItemBloc _sellerItemBloc;
  List<TextEditingController> _quantityTextEditingControllers;
  List<TextEditingController> _priceTextEditingControllers;
  String sellerName;

  @override
  void initState() {
    sellerName = widget.sellerBidData.sellerInfo.seller.name;
    _sellerItemBloc = SellerItemBloc(this, widget.sellerBidData.sellerInfo);
    super.initState();
  }

  @override
  void onValidationSuccess({Map<String, dynamic> sellerInfo}) {
    Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
        arguments: sellerInfo);
  }

  @override
  void onValidationError(String message) {
    showErrorMessage(message);
  }

  @override
  void onValidationEmpty(String message) {
    showErrorMessage(message);
  }

  void showErrorMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  @override
  Widget build(BuildContext context) {

    _quantityTextEditingControllers =
        getSellerBidMap().keys.map((_) => TextEditingController()).toList();
    _priceTextEditingControllers =
        getSellerBidMap().keys.map((_) => TextEditingController()).toList();

    return Scaffold(
        bottomNavigationBar: widget.sellerBidFlow == SellerBidFlow.bidFlow ? getBidActionView(): getSubmitButton(),
        appBar: HomeAppBar(
            text: sellerName,
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  final Item item = getItem(index);
                  final dynamic bidDataItem = getBidDataItem(index);
                  final TextEditingController quantityEditingController =
                      _quantityTextEditingControllers[index];
                  final TextEditingController priceEditingController =
                      _priceTextEditingControllers[index];

                  if(bidDataItem != null && bidDataItem["bidQuantity"] != null) {
                    _quantityTextEditingControllers[index].text = bidDataItem['bidQuantity'].toString();
                  }

                  if(bidDataItem != null && bidDataItem["bidCost"] != null) {
                    _priceTextEditingControllers[index].text = bidDataItem["bidCost"].toString();
                  }

                  return SellerItemListItem(
                      item: item,
                      bidData: bidDataItem,
                      quantityTextEditingController: quantityEditingController,
                      priceTextEditingController: priceEditingController,
                  sellerBidFlow: widget.sellerBidFlow);
                }, childCount: getChildCount()))
              ],
            ),
          ),
        ));
  }

  bool isPendingBid() {
    return widget.sellerBidData.bid?.status == BidStatus.pending;
  }

  List<String> _quantityValues() => _quantityTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  List<String> _priceValues() => _priceTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  Item getItem(int index) {

    return getSellerBidMap().keys.toList()[index];
  }

  Map getSellerBidMap() {
    if(widget.sellerBidFlow == SellerBidFlow.bidFlow) {
      return Map.from(widget.sellerBidData.sellerItemBidMap)..removeWhere((k,v)=> v==null);
    }

    return widget.sellerBidData.sellerItemBidMap;
  }

  dynamic getBidDataItem(int index) {
    return getSellerBidMap()[getSellerBidMap().keys.toList()[index]];
  }

  int getChildCount() {
    return getSellerBidMap().length;
  }

  Widget getBidActionView() {
    if(isPendingBid()) {
      return ButtonView(
          onButtonPressed: () {
            setState(() {
              widget.sellerBidFlow = SellerBidFlow.editBidFlow;
            });
          },
          text: Constants.BUTTON_EDIT_BID,
          insetT: 10.0,
          insetB: 10.0);
    } else {
      return RaisedButton(
        onPressed: () {},
          textColor: Colors.grey,
          child: Text(widget.sellerBidData.bid.status.toString()));
    }
  }

  Widget getSubmitButton() {
    return ButtonView(
        onButtonPressed: () {
          _sellerItemBloc.onSubmitBids(_quantityValues(), _priceValues(), widget.sellerBidData.bid);
        },
        text: Constants.BUTTON_SUBMIT,
        insetT: 10.0,
        insetB: 10.0);
  }
}

mixin SellerItemListener {
  void onValidationSuccess({Map<String, dynamic> sellerInfo});
  void onValidationError(String message);
  void onValidationEmpty(String message);
}

enum SellerBidFlow {
  sellerItemFlow,
  bidFlow,
  editBidFlow
}
