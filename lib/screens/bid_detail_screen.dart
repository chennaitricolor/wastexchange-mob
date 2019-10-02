import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/bid_detail_bloc.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/bid_details_header.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item.dart';
import 'package:wastexchange_mobile/widgets/views/bottom_action_view_container.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_compact.dart';
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

class _BidDetailScreenState extends State<BidDetailScreen>
    with SellerItemListener {
  _BidDetailScreenState({this.bid});

  BidDetailBloc _bloc;
  SellerItemBloc _sellerItemBloc;
  bool isEditMode = false;
  SellerItemDetails sellerItemDetails;
  bool _isCancelOperation = false;
  Bid bid;
  User seller;

  List<TextEditingController> _quantityTextEditingControllers;
  List<TextEditingController> _priceTextEditingControllers;
  Set<int> quantityErrorPositions = {};
  Set<int> priceErrorPositions = {};

  final _HEADER_COUNT = 1;

  @override
  void initState() {
    _bloc = BidDetailBloc();

    _bloc.sellerStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          break;
        case Status.COMPLETED:
          sellerItemDetails = _snapshot.data;

          _bloc.getUser(sellerItemDetails.sellerId).then((result) {
            dismissDialog(context);

            setState(() {
              if (result.status == Status.COMPLETED && result.data != null) {
                seller = result.data;

                _bloc.sortSellerItemsBasedOnBid(sellerItemDetails, bid);

                _sellerItemBloc = SellerItemBloc(this,
                    SellerInfo(seller: seller, items: sellerItemDetails.items));
                _quantityTextEditingControllers = sellerItemDetails.items
                    .map((_) => TextEditingController())
                    .toList();
                _priceTextEditingControllers = sellerItemDetails.items
                    .map((_) => TextEditingController())
                    .toList();

                for (int i = 0; i < sellerItemDetails.items.length; i++) {
                  final Item item = sellerItemDetails.items[i];
                  Item bidItem = bid.bidItems[item.name];

                  if (bidItem != null) {
                    _quantityTextEditingControllers[i].text =
                        bidItem.qty.toString();
                    _priceTextEditingControllers[i].text =
                        bidItem.price.toString();
                  }
                }
              }
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
          if (_isCancelOperation) {
            _isCancelOperation = false;
          }
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {
            if (_isCancelOperation) {
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
    return Scaffold(
        bottomNavigationBar: _isDataLoaded() && _isPendingBid()
            ? BottomActionViewContainer(children: <Widget>[
                ButtonViewCompact(
                    onPressed: () {
                      if (isEditMode) {
                        _sellerItemBloc.onSubmitBids(
                            _quantityValues(), _priceValues());
                      } else {
                        setState(() {
                          isEditMode = true;
                        });
                      }
                    },
                    text: isEditMode
                        ? Constants.BUTTON_SUBMIT
                        : Constants.BUTTON_EDIT_BID),
                ButtonViewCompact(
                    onPressed: () {
                      if (isEditMode) {
                        setState(() {
                          isEditMode = false;
                        });
                      } else {
                        _askCancelConfirmation();
                      }
                    },
                    text: isEditMode
                        ? Constants.BUTTON_CANCEL
                        : Constants.BUTTON_CANCEL_BID)
              ])
            : Row(),
        appBar: HomeAppBar(
            text: 'Order Id - ${bid.orderId}',
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _isDataLoaded() && !isListNullOrEmpty(sellerItemDetails.items)
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return index == 0
                          ? BidDetailsHeader(bid: bid, user: seller)
                          : SellerItemListItem(
                              item: sellerItemDetails.items[index - _HEADER_COUNT],
                              showQuantityFieldError: quantityErrorPositions
                                  .contains(index - _HEADER_COUNT),
                              showPriceFieldError: priceErrorPositions
                                  .contains(index - _HEADER_COUNT),
                              quantityTextEditingController:
                                  _quantityTextEditingControllers[
                                      index - _HEADER_COUNT],
                              priceTextEditingController:
                                  _priceTextEditingControllers[
                                      index - _HEADER_COUNT],
                              isEditable: isEditMode);
                    },
                    itemCount: isListNullOrEmpty(sellerItemDetails.items)
                        ? 0
                        : (sellerItemDetails.items.length + _HEADER_COUNT))
                : Row()));
  }

  bool _isPendingBid() => bid.status == BidStatus.pending;

  bool _isDataLoaded() => sellerItemDetails != null;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _askCancelConfirmation() {
    showConfirmationDialog(context, 'Cancel Bid',
        'Are you sure, You want to cancel the bid', 'Yes', 'No', (status) {
      if (status) {
        _isCancelOperation = true;
        _bloc.cancelBid(bid, sellerItemDetails);
      }
    });
  }

  List<String> _quantityValues() => _quantityTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  List<String> _priceValues() => _priceTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  @override
  void onValidationSuccess({Map<String, dynamic> sellerInfo}) {
    sellerInfo['previousBid'] = bid;
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

  //TODO: [Chandru] Need to unify the set state methods. It is unnecessary duplicated now.
  @override
  void onQuantityValidationError(String message, List<int> quantityErrors) {
    handleQuantityValidationError(message, quantityErrors);
  }

  @override
  void onPriceValidationError(String message, List<int> priceErrors) {
    handlePriceValidationError(message, priceErrors);
  }

  @override
  void onValidationEmpty(String message, List<int> errorPositions) {
    handleValidationEmpty(message, errorPositions);
  }

  void handlePriceValidationError(String message, List<int> priceErrors) {
    showErrorMessage(message);
    setState(() {
      quantityErrorPositions = {};
      priceErrorPositions = priceErrors.toSet();
    });
  }

  void handleQuantityValidationError(String message, List<int> quantityErrors) {
    showErrorMessage(message);
    setState(() {
      quantityErrorPositions = quantityErrors.toSet();
      priceErrorPositions = {};
    });
  }

  void handleValidationEmpty(String message, List<int> errorPositions) {
    showErrorMessage(message);
    setState(() {
      quantityErrorPositions = errorPositions.toSet();
      priceErrorPositions = errorPositions.toSet();
    });
  }
}
