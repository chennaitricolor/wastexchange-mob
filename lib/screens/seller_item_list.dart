import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/widgets/seller_item_cell.dart';

class SellerItemsList extends StatefulWidget {
  const SellerItemsList(this.seller);

  final User seller;

  @override
  _SellerItemsListState createState() => _SellerItemsListState();
}

class _SellerItemsListState extends State<SellerItemsList> {
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

    return FutureBuilder(
      future: UserRepository().getSellerDetails(_seller.id),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        final isSuccess = snapShot.connectionState == ConnectionState.done &&
            snapShot.hasData;
        if (!isSuccess) {
          return Align(
            alignment: Alignment.topCenter,
            child: const CircularProgressIndicator(),
          );
        }
        final SellerItemDetails sellerItemDetails = snapShot.data;
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
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    endIndent: 16.0,
                    indent: 16.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return SellerItemCell(item);
                  },
                ),
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
