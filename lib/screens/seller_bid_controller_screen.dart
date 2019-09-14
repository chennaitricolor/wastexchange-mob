import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_bid_data.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/screens/seller_bid_screen.dart';

class SellerBidController extends StatefulWidget {

  SellerBidController({this.bid});

  final Bid bid;

  static const routeName = '/bidItemScreen';

  @override
  State<StatefulWidget> createState() {
    return SellerBidState();
  }
}

class SellerBidState extends State<SellerBidController> {

  SellerItemDetailsBloc _sellerItemDetailBloc;

  bool _isDataFetched = false;
  bool _isDataFetchError = false;
  SellerBidData sellerBidData;
  SellerBidFlow sellerBidFlow = SellerBidFlow.bidFlow;

  @override
  Widget build(BuildContext context) {

    print("build called");

    if(_isDataFetched) {
      return SellerBidScreen(sellerBidData: sellerBidData, sellerBidFlow: sellerBidFlow, onEditClickedCallback: () {
       setState(() {
         sellerBidFlow = SellerBidFlow.editBidFlow;
       });
      });
    } else if(_isDataFetchError) {
      return _errorView;
    } else {
      return _loadingView;
    }
  }

  Widget get _loadingView {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }

  Widget get _errorView {
    return Scaffold(
        body: Center(
            child: Text("Unable to fetch data")
        )
    );
  }

  @override
  void initState() {
    _sellerItemDetailBloc = SellerItemDetailsBloc();
    _sellerItemDetailBloc.sellerItemDetailsStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          break;
        case Status.ERROR:
          print("error");
          setState(() {
            _isDataFetchError = true;
          });
          break;
        case Status.COMPLETED:
          final _sellerItemDetails = _snapshot.data;
          UserRepository().getUser(id: widget.bid.sellerId, forceNetwork: false).then((value) {
            if(value.status == Status.COMPLETED) {
              setState(() {
                _isDataFetched = true;
                sellerBidData = SellerBidData(sellerInfo: SellerInfo(seller: value.data, items: _sellerItemDetails.items), bid: widget.bid);
              });
            } else {
              setState(() {
                _isDataFetchError = true;
              });
            }
          });
          break;
      }
    });

    _sellerItemDetailBloc.getSellerDetails(widget.bid.sellerId);
    super.initState();
  }

  @override
  void dispose() {
    _sellerItemDetailBloc.dispose();
    super.dispose();
  }

}
