import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/sellert_Item_bloc.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_list_item.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class SellerItemScreen extends StatefulWidget {
  SellerItemScreen({this.sellerInfo}) {
    ArgumentError.checkNotNull(sellerInfo);
    ArgumentError.checkNotNull(sellerInfo.seller);
    ArgumentError.checkNotNull(sellerInfo.items);
    if (sellerInfo.items.isEmpty) {
      throw Exception('Seller Items is empty');
    }
  }

  final SellerInfo sellerInfo;

  static const routeName = '/sellerItemScreen';

  @override
  _SellerItemScreenState createState() => _SellerItemScreenState();
}

class _SellerItemScreenState extends State<SellerItemScreen>
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
    sellerName = widget.sellerInfo.seller.name;
    _sellerItemBloc = SellerItemBloc(this, widget.sellerInfo);
    _quantityTextEditingControllers =
        widget.sellerInfo.items.map((_) => TextEditingController()).toList();
    _priceTextEditingControllers =
        widget.sellerInfo.items.map((_) => TextEditingController()).toList();
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
    return Scaffold(
        bottomNavigationBar: ButtonView(
            onButtonPressed: () {
              _sellerItemBloc.onSubmitBids(_quantityValues(), _priceValues());
            },
            text: Constants.BUTTON_SUBMIT,
            insetT: 10.0,
            insetB: 10.0),
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
                  final Item item = widget.sellerInfo.items[index];
                  final TextEditingController quantityEditingController =
                      _quantityTextEditingControllers[index];
                  final TextEditingController priceEditingController =
                      _priceTextEditingControllers[index];
                  return SellerItemListItem(
                      item: item,
                      quantityTextEditingController: quantityEditingController,
                      priceTextEditingController: priceEditingController);
                }, childCount: widget.sellerInfo.items.length))
              ],
            ),
          ),
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
  void onValidationError(String message);
  void onValidationEmpty(String message);
}
