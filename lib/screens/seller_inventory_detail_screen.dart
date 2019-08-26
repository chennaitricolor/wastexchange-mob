import 'package:flutter/material.dart';

import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/token_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/screens/seller-information-screen.dart';
import 'package:wastexchange_mobile/screens/seller_detail_header.dart';
import 'package:wastexchange_mobile/screens/seller_detail_header_no_detail.dart';
import 'package:wastexchange_mobile/widgets/loading_progress_indicator.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/widgets/seller_items_list.dart';

class SellerInventoryDetailScreen extends StatefulWidget {
  const SellerInventoryDetailScreen(this.seller);

  final User seller;

  void updateSeller(User seller) {
    seller = seller;
  }

  @override
  _SellerInventoryDetailScreenState createState() =>
      _SellerInventoryDetailScreenState();
}

class _SellerInventoryDetailScreenState
    extends State<SellerInventoryDetailScreen> {
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
    if (TokenRepository.sharedInstance.isAuthorized()) {
      _routeToSellerInformationScreen();
    } else {
      _routeToLoginScreen();
    }
  }

  SellerInformation _getSellerInfo() {
    return SellerInformation(
      sellerItems: _sellerItemDetails.items,
      seller: _seller(),
    );
  }

  void _routeToLoginScreen() {
    Router.pushNamed(context, LoginScreen.routeName,
        arguments: _getSellerInfo());
  }

  void _routeToSellerInformationScreen() {
    Router.pushNamed(context, SellerInformationScreen.routeName,
        arguments: _getSellerInfo());
  }

  @override
  Widget build(BuildContext context) {
    if (_seller() == null) {
      return SellerDetailHeaderNoDetail(
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
            SellerDetailHeader(
              onPressed: _routeToNextScreen,
              name: _seller().name,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: SellerItemList(
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
