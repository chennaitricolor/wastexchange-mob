import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/blocs/bid_bloc.dart';
import 'package:wastexchange_mobile/models/bid_item.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_data.dart';
import 'package:wastexchange_mobile/models/item.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/widget_display_util.dart';

class BuyerBidConfirmationScreen extends StatefulWidget {
  @override
  _BuyerBidConfirmationScreenState createState() =>
      _BuyerBidConfirmationScreenState();
}

class _BuyerBidConfirmationScreenState
    extends State<BuyerBidConfirmationScreen> {
  BidBloc _bloc;
  final contactNameController = TextEditingController();
  final pickupDateController = TextEditingController();
  final pickupTimeController = TextEditingController();

  final dateFormat = DateFormat(Constants.DATE_FORMAT);
  final timeFormat = DateFormat(Constants.TIME_FORMAT);
  var initialPickupTime = DateTime.now().add(Duration(hours: 18));

  final _formKey = GlobalKey<FormState>();
  final _scafffoldState = GlobalKey<ScaffoldState>();
  bool _isEnabled = true;

  final List<BidItem> _itemsList = [
    BidItem(
        bidCost: 5,
        bidQuantity: 5,
        item: Item(name: 'glassBottles', price: 20, qty: 10)),
  ];

  @override
  void initState() {
    _bloc = BidBloc();
    _bloc.bidStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          DisplayUtil.instance.showLoadingDialog(context);
          break;
        case Status.ERROR:
          DisplayUtil.instance.dismissDialog(context);
          break;
        case Status.COMPLETED:
          if (_snapshot.data.auth) {
            DisplayUtil.instance.dismissDialog(context);
            //Success Message
            setState(() {
              _scafffoldState.currentState.showSnackBar(SnackBar(
                content: Text(Constants.BID_SUCCESS_MSG),
                duration: Duration(seconds: 3),
              ));
            });
          }
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafffoldState,
        appBar: AppBar(
          title: Text(Constants.TITLE_ORDER_FORM),
          backgroundColor: AppColors.colorAccent,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextFormField(
                    controller: contactNameController,
                    decoration: InputDecoration(
                      hintText: Constants.FIELD_CONTACT_NAME,
                      labelText: Constants.FIELD_CONTACT_NAME,
                    ),
                    enabled: _isEnabled,
                    validator: (value) {
                      if (value.isEmpty) {
                        return Constants.FIELD_CONTACT_NAME_ERROR_MSG;
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: DateTimeField(
                    format: dateFormat,
                    decoration: InputDecoration(
                      hintText: Constants.FIELD_PICKUP_DATE,
                      labelText: Constants.FIELD_PICKUP_DATE,
                    ),
                    enabled: _isEnabled,
                    controller: pickupDateController,
                    onShowPicker: (context, currentValue) async {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? initialPickupTime,
                          lastDate: DateTime(2100));
                    },
                    validator: (value) {
                      final int diffDays =
                          value.difference(initialPickupTime).inDays;
                      if (diffDays < 0) {
                        return Constants.FIELD_PICKUP_DATE_ERROR_MSG;
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: DateTimeField(
                    format: timeFormat,
                    controller: pickupTimeController,
                    decoration: InputDecoration(
                      hintText: Constants.FIELD_PICKUP_TIME,
                      labelText: Constants.FIELD_PICKUP_TIME,
                    ),
                    enabled: _isEnabled,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(initialPickupTime),
                      );
                      final combinedDateTime = DateTimeField.combine(
                          DateTime.parse(pickupDateController.text), time);
                      return combinedDateTime;
                    },
                    validator: (value) {
                      final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(value);
                      final combinedDateTime = DateTimeField.combine(
                          DateTime.parse(pickupDateController.text), timeOfDay);
                      final int diffHours = combinedDateTime
                          .difference(initialPickupTime)
                          .inHours;
                      final int diffMinutes = combinedDateTime
                          .difference(initialPickupTime)
                          .inMinutes;
                      if (diffHours < 0 && diffMinutes < 0) {
                        return Constants.FIELD_PICKUP_TIME_ERROR_MSG;
                      }
                      return null;
                    },
                  )),
              Offstage(
                  offstage: !_isEnabled,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.check),
                                    color: AppColors.colorAccent,
                                    iconSize: 32,
                                    onPressed: () {
                                      // if (_formKey.currentState.validate()) {
                                      sendBidFormData();
                                      // }
                                    },
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.cancel),
                                    color: AppColors.colorAccent,
                                    iconSize: 32,
                                    onPressed: () {},
                                  ))),
                        ],
                      ))),
              Offstage(
                offstage: _isEnabled,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: RaisedButton(
                                  color: AppColors.colorAccent,
                                  child: Text(Constants.BUTTON_HOME_PAGE),
                                  onPressed: () {},
                                ))),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: RaisedButton(
                                  color: AppColors.colorAccent,
                                  child: Text(Constants.BUTTON_LIST_OF_BIDS),
                                  onPressed: () {},
                                ))),
                      ],
                    )),
              )
            ],
          ),
        )));
  }

  //implementation yet to add
  //send data to bid form api
  //disable fields after success
  void sendBidFormData() {
    // setState(() {
    //   _isEnabled = false;
    // });

//TODO (Sayeed): Verify _itemsList with Web works fine, check status possible values, why is totalBid an integer.
    final BuyerBidData data = BuyerBidData(
        bidItems: _itemsList,
        sellerId: 1,
        totalBid: 20,
        pDateTime: DateTime.now(),
        contactName: 'Surya',
        status: 'pending');
    _bloc.placeBid(data);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
