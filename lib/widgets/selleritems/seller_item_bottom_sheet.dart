import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_header.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_header_empty.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet_list.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';

enum _UIStatus { LOADING, ERROR, COMPLETED }

class SellerItemBottomSheet extends StatefulWidget {
  SellerItemBottomSheet({@required this.seller});
  User seller;
  final _SellerItemBottomSheetState _state = _SellerItemBottomSheetState();

  void setUser(User user) {
    seller = user;
    _state._reload();
  }

  @override
  _SellerItemBottomSheetState createState() => _state;
}

class _SellerItemBottomSheetState extends State<SellerItemBottomSheet> {
  SellerItemDetailsBloc _bloc;
  SellerItemDetails _sellerItemDetails;
  _UIStatus _status = _UIStatus.LOADING;

  bool hasSeller() => isNotNull(widget.seller);
  bool isAuthorized() => TokenRepository().isAuthorized();

  @override
  void initState() {
    _bloc = SellerItemDetailsBloc();
    _bloc.sellerItemDetailsStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          setState(() {
            _status = _UIStatus.LOADING;
          });
          break;
        case Status.ERROR:
          setState(() {
            _status = _UIStatus.ERROR;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            _sellerItemDetails = _snapshot.data;
            _status = _UIStatus.COMPLETED;
          });

          break;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _reload() {
    _bloc.getSellerDetails(widget.seller.id);
  }

  SellerInfo _getSellerInfo() {
    return SellerInfo(seller: widget.seller, items: _sellerItemDetails.items);
  }

  void _routeToNextScreen() {
    // TODO(Sayeed): Fix this items usage later.
    final items = _sellerItemDetails.items ?? [];

    if (isAuthorized()) {
      _routeToSellerItemScreen();
    } else {
      if (items.isNotEmpty) {
        _routeToLoginScreenWithSellerInfo();
      } else {
        _routeToLoginScreen();
      }
    }
  }

  void _routeToLoginScreen() {
    Router.pushNamed(context, LoginScreen.routeName);
  }

  void _routeToLoginScreenWithSellerInfo() {
    Router.pushNamed(context, LoginScreen.routeName,
        arguments: _getSellerInfo());
  }

  void _routeToSellerItemScreen() {
    Router.pushNamed(context, SellerItemScreen.routeName,
        arguments: _getSellerInfo());
  }

  Widget _widgetForUIStatus() {
    if (_status == _UIStatus.LOADING) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoadingProgressIndicator(
            alignment: Alignment.topCenter,
          ));
    } else if (_status == _UIStatus.ERROR) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: const Text(Constants.GENERIC_ERROR_MESSAGE),
          ));
    } else {
      final items = _sellerItemDetails.items ?? [];
      return Column(
        children: <Widget>[
          Icon(
            Icons.drag_handle,
            size: 25.0,
          ),
          SellerItemBottomSheetHeader(
            onPressed: _routeToNextScreen,
            name: widget.seller.name,
            isAuthorized: isAuthorized(),
            hasItems: items.isNotEmpty,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasSeller()) {
      return SellerItemBottomSheetHeaderEmpty(
        onPressed: _routeToLoginScreen,
        isAuthorized: isAuthorized(),
      );
    }
    return _widgetForUIStatus();
  }
}
