import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/bid_detail_bloc.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_screen_launch_data.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
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
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item.dart';
import 'package:wastexchange_mobile/widgets/views/bottom_action_view_container.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_compact.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:wastexchange_mobile/widgets/dialogs/dialog_util.dart';

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

  static const headerCount = 1;

  @override
  void initState() {
    _bloc = BidDetailBloc();

// TODO(Sayeed): Why are we listening to this stream
    _bloc.sellerStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.loading:
          showLoadingDialog(context);
          break;
        case Status.error:
          dismissDialog(context);
          break;
        case Status.completed:
          sellerItemDetails = _snapshot.data;
          final sellerItems = sellerItemDetails.items;

          _bloc.getUser(sellerItemDetails.sellerId).then((result) {
            dismissDialog(context);

            setState(() {
              if (result.status == Status.completed && result.data != null) {
                seller = result.data;

                _bloc.sortSellerItemsBasedOnBid(sellerItemDetails, bid);

                _sellerItemBloc = SellerItemBloc(this,
                    SellerInfo(seller: seller, items: sellerItems));
                _quantityTextEditingControllers = sellerItems
                    .map((_) => TextEditingController())
                    .toList();
                _priceTextEditingControllers = sellerItems
                    .map((_) => TextEditingController())
                    .toList();

                for (int i = 0; i < sellerItems.length; i++) {
                  final Item item = sellerItems[i];
                  final Item bidItem = bid.nameToItemMap[item.name];

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
        case Status.loading:
          showLoadingDialog(context);
          break;
        case Status.error:
          print(_snapshot.message);
          dismissDialog(context);
          if (_isCancelOperation) {
            _isCancelOperation = false;
          }
          break;
        case Status.completed:
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
                    width: 160,
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
                    width: 160,
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
            child: _isDataLoaded() &&
                    !isListNullOrEmpty(sellerItemDetails.items)
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return index == 0
                          ? BidDetailsHeader(bid: bid, user: seller)
                          : SellerItemListItem(
                              item:
                                  sellerItemDetails.items[index - headerCount],
                              showQuantityFieldError: quantityErrorPositions
                                  .contains(index - headerCount),
                              showPriceFieldError: priceErrorPositions
                                  .contains(index - headerCount),
                              quantityTextEditingController:
                                  _quantityTextEditingControllers[
                                      index - headerCount],
                              priceTextEditingController:
                                  _priceTextEditingControllers[
                                      index - headerCount],
                              isEditable: isEditMode);
                    },
                    itemCount: isListNullOrEmpty(sellerItemDetails.items)
                        ? 0
                        : (sellerItemDetails.items.length + headerCount))
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
        'Are you sure, you want to cancel the bid', 'Yes', 'No', (status) {
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
    final pickupInfoData = PickupInfoData(
        contactName: bid.contactName,
        pickupDate: bid.pickupDate,
        pickupTime: bid.pickupDate);
    final BuyerBidConfirmationScreenLaunchData data =
        BuyerBidConfirmationScreenLaunchData(
      seller: sellerInfo['seller'],
      isEditBid: true,
      orderId: bid.orderId,
      bidItems: sellerInfo['bidItems'],
      pickupInfoData: pickupInfoData,
    );
    Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
        arguments: data);
  }

  void showErrorMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: const Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  // TODO(Chandru): Need to unify the set state methods. It is unnecessary duplicated now.
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
