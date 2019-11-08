import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/my_bids_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/ui_state.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/bid_detail_screen.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/dialogs/dialog_util.dart';
import 'package:wastexchange_mobile/widgets/my_bids_item.dart';
import 'package:wastexchange_mobile/widgets/views/empty_page_view.dart';
import 'package:wastexchange_mobile/widgets/views/error_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class MyBidsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBidsScreenState();

  static const routeName = '/myBidsScreen';
}

class _MyBidsScreenState extends State<MyBidsScreen> {
  UIState _uiState = UIState.loading;
  String _errorMessage = Constants.GENERIC_ERROR_MESSAGE;

  MyBidsBloc _bloc;

  @override
  void initState() {
    _bloc = MyBidsBloc();
    _bloc.myBidsStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.loading:
          showLoadingDialog(context);
          setState(() {
            _uiState = UIState.loading;
          });
          break;
        case Status.error:
          dismissDialog(context);
          setState(() {
            _uiState = UIState.error;
            _errorMessage = _snapshot.message;
          });
          break;
        case Status.completed:
          dismissDialog(context);
          setState(() {
            _uiState = UIState.completed;
          });
          break;
      }
    });
    _bloc.myBids();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void showBidDetail(Bid bid) {
    Router.pushNamed(context, BidDetailScreen.routeName, arguments: bid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
          text: Constants.MY_BIDS,
          onBackPressed: () {
            Navigator.pop(context, false);
          }),
      body: Scrollbar(child: _widgetForUIState()),
    );
  }

// TODO(Sayeed): Fix this anti pattern of returning widgets from method
  Widget _widgetForUIState() {
    switch (_uiState) {
      case UIState.loading:
        // return const LoadingView(message: 'Loading Bids');
        return EmptyPageView(message: Constants.LOADING_BIDS);
      case UIState.completed:
        return _bloc.bidCount() == 0
            ? EmptyPageView(message: Constants.NO_BIDS_MESSAGE)
            : ListView.builder(
                itemCount: _bloc.bidCount(),
                itemBuilder: (context, index) {
                  final Bid bid = _bloc.bidAtIndex(index);
                  final User user = _bloc.user(id: bid.sellerId);
                  return MyBidsItem(
                      bid: bid,
                      seller: user,
                      onPressed: () {
                        showBidDetail(bid);
                      });
                },
              );
      default:
        return ErrorView(
            message: _errorMessage,
            retryCallback: () {
              _bloc.myBids();
            });
    }
  }
}
