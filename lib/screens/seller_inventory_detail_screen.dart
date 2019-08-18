import 'package:flutter/material.dart';

import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/widgets/loading_progress_indicator.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/widgets/seller_items_list.dart';

class SellerInventoryDetailScreen extends StatefulWidget {
  const SellerInventoryDetailScreen(this.seller);

  final User seller;

  @override
  _SellerInventoryDetailScreenState createState() =>
      _SellerInventoryDetailScreenState();
}

class _SellerInventoryDetailScreenState
    extends State<SellerInventoryDetailScreen> {
  SellerItemDetailsBloc _bloc;

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

  void _routeToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final _seller = widget.seller;
    if (_seller == null) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: RaisedButton(
            color: Colors.white,
            child: const Text(
              'Login to buy',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25.0,
              ),
            ),
            onPressed: () {
              _routeToLogin();
            },
          ),
        ),
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

        final SellerItemDetails sellerItemDetails = result.data;
        final items = sellerItemDetails.items;
        return Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.drag_handle,
                size: 14.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 64.0,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    _seller.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SellerItemList(items: items),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: RaisedButton(
                  color: Colors.white,
                  child: const Text(
                    'Login to buy',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    _routeToLogin();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
