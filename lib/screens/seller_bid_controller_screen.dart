import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/seller_item_details_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_bid_data.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/resources/user_repository.dart';
import 'package:wastexchange_mobile/screens/seller_bid_screen.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class SellerBidController extends StatefulWidget {

  SellerBidController({this.bid});

  final Bid bid;

  static const routeName = '/bidItemScreen';

  @override
  State<StatefulWidget> createState() {
    return SellerBidState(bid);
  }
}

class SellerBidState extends State<SellerBidController> {

  SellerBidState(this.bid);

  final Bid bid;

  SellerItemDetailsBloc _sellerItemDetailBloc;

  bool _isDataFetched = false;
  bool _isDataFetchError = false;
  SellerBidData sellerBidData;
  SellerBidFlow sellerBidFlow = SellerBidFlow.bidFlow;
  SellerBidScreen _sellerBidScreen;

  @override
  Widget build(BuildContext context) {

    if(_isDataFetched) {
      return getSellerBidScreen();
    } else if(_isDataFetchError) {
      return _errorView;
    } else {
      return _loadingView;
    }
  }

  Widget get _loadingView {
    return Scaffold(
        appBar: HomeAppBar(
            text: 'Bid Details'),
      body: Center(
        child: CircularProgressIndicator(
        ),
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
          UserRepository().getUser(id: bid.sellerId, forceNetwork: false).then((value) {
            if(value.status == Status.COMPLETED) {
              setState(() {
                _isDataFetched = true;
                sellerBidData = SellerBidData(sellerInfo: SellerInfo(seller: value.data, items: _sellerItemDetails.items), bid: bid);
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

    _sellerItemDetailBloc.getSellerDetails(bid.sellerId);
    super.initState();
  }

  SellerBidScreen getSellerBidScreen() {
    _sellerBidScreen ??= SellerBidScreen(sellerBidData: sellerBidData, sellerBidFlow: sellerBidFlow);

    return _sellerBidScreen;
  }

  @override
  void dispose() {
    _sellerItemDetailBloc.dispose();
    super.dispose();
  }

}
