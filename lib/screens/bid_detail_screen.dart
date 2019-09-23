import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/bid_detail_bloc.dart';
import 'package:wastexchange_mobile/models/bid.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_item_details_response.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';
import 'package:wastexchange_mobile/widgets/views/button_view.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class BidDetailScreen extends StatefulWidget {

  BidDetailScreen({this.bid}) {
    ArgumentError.checkNotNull(bid);
  }

  final Bid bid;

  @override
  State<StatefulWidget> createState() => _BidDetailScreenState();

  static const routeName = '/bidDetailScreen';
}

class _BidDetailScreenState extends State<BidDetailScreen> {

  BidDetailBloc _bloc;
  bool isEditMode = false;
  SellerItemDetails sellerItemDetails;
  bool _isCancelOperation = false;

  @override
  void initState() {
    _bloc = BidDetailBloc();
    _bloc.sellerStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          print(_snapshot.message);
          dismissDialog(context);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {
            print(_snapshot.data);
            sellerItemDetails = _snapshot.data;
          });
          break;
      }
    });
    _bloc.bidStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          print(_snapshot.message);
          dismissDialog(context);
          if(_isCancelOperation) {
            _isCancelOperation = false;
          }
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          setState(() {
            if(_isCancelOperation) {
              _isCancelOperation = false;
              widget.bid.status = BidStatus.cancelled;
            }
          });
          break;
      }
    });
    _bloc.getSellerDetails(widget.bid.sellerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: isPendingBid()? isEditMode ? getSubmitAndCancelButtons() : getEditAndCancelBidButtons() : Column(),
        backgroundColor: AppColors.chrome_grey,
        appBar: HomeAppBar(
            text: 'Order Id : ${widget.bid.orderId}',
            onBackPressed: () {
              Navigator.pop(context, false);
            }),
        body: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
        ));
  }

  bool isPendingBid() {
    return widget.bid.status == BidStatus.pending;
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget getSubmitAndCancelButtons() {
    return Row(children: <Widget>[
      ButtonView(
          onButtonPressed: () {
            setState(() {
              isEditMode = false;
            });
          },
          buttonStyle: getSmallButtonStyle(),
          text: Constants.BUTTON_CANCEL),
      ButtonView(
          onButtonPressed: () {

          },
          buttonStyle: getSmallButtonStyle(),
          text: Constants.BUTTON_SUBMIT)
    ]);
  }

  Widget getEditAndCancelBidButtons() {
    return Row(children: <Widget>[
      ButtonView(
          onButtonPressed: () {
            askCancelConfirmation();
          },
        buttonStyle: getSmallButtonStyle(),
        text: Constants.BUTTON_CANCEL_BID,),
      ButtonView(
          onButtonPressed: () {
            setState(() {
              isEditMode = true;
            });
          },
          buttonStyle: getSmallButtonStyle(),
          text: Constants.BUTTON_EDIT_BID)
    ]);
  }

  void askCancelConfirmation() {
   showConfirmationDialog(context, "Cancel Bid", "Are you sure, You want to cancel the bid", "Yes", "No", (status) {
     if(status) {
       _isCancelOperation = true;
       _bloc.cancelBid(widget.bid, sellerItemDetails);
     }
   });
  }
}
