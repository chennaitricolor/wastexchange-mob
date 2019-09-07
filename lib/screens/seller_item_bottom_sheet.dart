import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_item.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_header.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_header_empty.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_list.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';

class SellerItemBottomSheet extends StatefulWidget {
  const SellerItemBottomSheet(this.seller);

  final User seller;

  @override
  _SellerItemBottomSheetState createState() => _SellerItemBottomSheetState();
}

class _SellerItemBottomSheetState extends State<SellerItemBottomSheet> {
  SellerItemDetailsBloc _bloc;
  SellerItemDetails _sellerItemDetails;

  bool hasSeller() => !isNull(widget.seller);
  bool hasSellerItemDetails() => !isNull(_sellerItemDetails);

  @override
  void initState() {
    _bloc = SellerItemDetailsBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _fetchSellerDetails() {
    _bloc.getSellerDetails(widget.seller.id);
  }

  void _routeToNextScreen() {
    TokenRepository().isAuthorized()
        ? _routeToSellerItemScreen()
        : _routeToLoginScreen();
  }

  SellerItem _getSellerInfo() {
    if (!hasSellerItemDetails()) {
      return null;
    }
    return SellerItem(
      sellerItems: _sellerItemDetails.items,
      seller: widget.seller,
    );
  }

  void _routeToLoginScreen() {
    if (!hasSellerItemDetails()) {
      Router.pushNamed(context, LoginScreen.routeName);
      return;
    }
    Router.pushNamed(context, LoginScreen.routeName,
        arguments: _getSellerInfo());
  }

  void _routeToSellerItemScreen() {
    Router.pushNamed(context, SellerItemScreen.routeName,
        arguments: _getSellerInfo());
  }

  @override
  Widget build(BuildContext context) {
    if (!hasSeller()) {
      return SellerItemBottomSheetHeaderEmpty(
        onPressed: _routeToNextScreen,
      );
    }

    _fetchSellerDetails();

    return StreamBuilder(
      stream: _bloc.sellerItemDetailsStream,
      builder: (context, snapShot) {
        final Result result = snapShot.data;
        switch (result.status) {
          case Status.LOADING:
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoadingProgressIndicator(
                  alignment: Alignment.topCenter,
                ));
          case Status.ERROR:
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(result.message),
                ));
          case Status.COMPLETED:
            break;
        }

        _sellerItemDetails = result.data;
        final items = _sellerItemDetails.items;
        return Column(
          children: <Widget>[
            Icon(
              Icons.drag_handle,
              size: 25.0,
            ),
            SellerItemBottomSheetHeader(
              onPressed: _routeToNextScreen,
              name: widget.seller.name,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: SellerItemBottomSheetList(
                  items: items,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
