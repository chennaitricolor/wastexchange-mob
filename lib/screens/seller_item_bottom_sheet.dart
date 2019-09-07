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
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_header.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_header_empty.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_list.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';

class SellerItemBottomSheet extends StatefulWidget {
  const SellerItemBottomSheet(this.seller);

  final User seller;

  void updateSeller(User seller) {
    seller = seller;
  }

  @override
  _SellerItemBottomSheetState createState() => _SellerItemBottomSheetState();
}

class _SellerItemBottomSheetState extends State<SellerItemBottomSheet> {
  SellerItemDetailsBloc _bloc;
  User _seller() => widget.seller;
  SellerItemDetails _sellerItemDetails;

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
    if (widget.seller != null) {
      _bloc.getSellerDetails(widget.seller.id);
    }
  }

  void _routeToNextScreen() {
    if (TokenRepository().isAuthorized()) {
      _routeToSellerItemScreen();
    } else {
      _routeToLoginScreen();
    }
  }

  SellerItem _getSellerInfo() {
    if (_seller() == null || _sellerItemDetails == null) {
      return null;
    }
    return SellerItem(
      sellerItems: _sellerItemDetails.items,
      seller: _seller(),
    );
  }

  void _routeToLoginScreen() {
    if (_getSellerInfo() != null) {
      Router.pushNamed(context, LoginScreen.routeName,
          arguments: _getSellerInfo());
      return;
    }
    Router.pushNamed(context, LoginScreen.routeName);
  }

  void _routeToSellerItemScreen() {
    Router.pushNamed(context, SellerItemScreen.routeName,
        arguments: _getSellerInfo());
  }

  @override
  Widget build(BuildContext context) {
    if (_seller() == null) {
      return SellerItemBottomSheetHeaderEmpty(
        onPressed: _routeToNextScreen,
      );
    }

    _fetchSellerDetails();
    return StreamBuilder(
      stream: _bloc.sellerItemDetailsStream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return LoadingProgressIndicator(
            alignment: Alignment.topCenter,
          );
        }

        final Result result = snapShot.data;
        switch (result.status) {
          case Status.LOADING:
            return LoadingProgressIndicator(
              alignment: Alignment.topCenter,
            );
          case Status.ERROR:
            return Align(
              alignment: Alignment.topCenter,
              child: Text(result.message),
            );
          case Status.COMPLETED:
            break;
        }

        _sellerItemDetails = result.data;
        final items = _sellerItemDetails.items;
        return Column(
          children: <Widget>[
            Icon(
              Icons.drag_handle,
              size: 14.0,
            ),
            SellerItemBottomSheetHeader(
              onPressed: _routeToNextScreen,
              name: _seller().name,
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
