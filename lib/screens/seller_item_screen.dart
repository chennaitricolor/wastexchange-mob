import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_screen_launch_data.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/resources/pickup_info_data_store.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/below_app_bar_message.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class SellerItemScreen extends StatefulWidget {
  SellerItemScreen({this.sellerInfo}) {
    ArgumentError.checkNotNull(sellerInfo);
    ArgumentError.checkNotNull(sellerInfo.seller);
    ArgumentError.checkNotNull(sellerInfo.items);
    // TODO(Sayeed): Can we simplify throwing exceptions like below across the app
    if (sellerInfo.items.isEmpty) {
      throw Exception('Seller Items is empty');
    }
  }

  final SellerInfo sellerInfo;

  static const routeName = '/sellerItemScreen';

  @override
  _SellerItemScreenState createState() => _SellerItemScreenState();
}

// TODO(Sayeed): We have a mixin pattern for callback here where as in other places we have bloc/streams.
//We should discuss and agree on one style for consistency
class _SellerItemScreenState extends State<SellerItemScreen>
    with SellerItemListener {
  final logger = AppLogger.get('SellerInformationScreen');
  Map<int, List<int>> validationMap = {};
  SellerItemBloc _sellerItemBloc;
  List<TextEditingController> _quantityTextEditingControllers;
  List<TextEditingController> _priceTextEditingControllers;
  String sellerName;
  List<BidItem> bidItems;
  Set<int> quantityErrorPositions = {};
  Set<int> priceErrorPositions = {};
  bool _restoreSavedState = false;

  @override
  void initState() {
    sellerName = widget.sellerInfo.seller.name;
    _sellerItemBloc = SellerItemBloc(this, widget.sellerInfo);
    final sellerItems = widget.sellerInfo.items;
    bidItems = sellerItems.map((item) => BidItem(item: item)).toList();
    _quantityTextEditingControllers =
        widget.sellerInfo.items.map((_) => TextEditingController()).toList();
    _priceTextEditingControllers =
        widget.sellerInfo.items.map((_) => TextEditingController()).toList();
    super.initState();
  }

  @override
  void onValidationSuccess({Map<String, dynamic> sellerInfo}) {
    final VoidCallback onBackPressedFromNextScreen = () {
      _restoreSavedState = true;
    };
    final pickupInfoData =
        _restoreSavedState ? PickupInfoDatastore().getData() : null;
    final BuyerBidConfirmationScreenLaunchData data =
        BuyerBidConfirmationScreenLaunchData(
      seller: sellerInfo['seller'],
      bidItems: sellerInfo['bidItems'],
      isEditBid: false,
      pickupInfoData: pickupInfoData,
      onBackPressed: onBackPressedFromNextScreen,
    );
    Router.pushNamed(context, BuyerBidConfirmationScreen.routeName,
        arguments: data);
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

  void resetStates() {
    setState(() {
      quantityErrorPositions = {};
      priceErrorPositions = {};
    });
  }

  void showErrorMessage(String message) {
    setState(() {});
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: const Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ButtonView(
            onButtonPressed: () {
              resetStates();
              _sellerItemBloc.onSubmitBids(_quantityValues(), _priceValues());
            },
            text: Constants.BUTTON_SUBMIT,
            insetT: 10.0,
            insetB: 10.0),
        appBar: HomeAppBar(
            text: 'Seller Items',
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Column(
          children: <Widget>[
            BelowAppBarMessage(message: sellerName),
            const SizedBox(height: 16),
            Expanded(
              child: SellerItemList(
                  quantityErrorPositions: quantityErrorPositions,
                  priceErrorPositions: priceErrorPositions,
                  bidItems: bidItems,
                  quantityEditingControllers: _quantityTextEditingControllers,
                  priceEditingControllers: _priceTextEditingControllers),
            ),
          ],
        ));
  }

  List<String> _quantityValues() => _quantityTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();

  List<String> _priceValues() => _priceTextEditingControllers
      .map((textEditingController) => textEditingController.text)
      .toList();
}

mixin SellerItemListener {
  void onValidationSuccess({Map<String, dynamic> sellerInfo});
  void onQuantityValidationError(String message, List<int> quantityErrors);
  void onPriceValidationError(String message, List<int> priceErrors);
  void onValidationEmpty(String message, List<int> errorPositions);
}
