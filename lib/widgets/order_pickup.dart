import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wastexchange_mobile/blocs/order_pickup_bloc.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/commons/card_view.dart';
import 'package:wastexchange_mobile/widgets/custom_time_picker.dart';
import 'package:wastexchange_mobile/widgets/tappable_card.dart';

class OrderPickup extends StatefulWidget {
  const OrderPickup({Key key}) : super(key: key);
  @override
  OrderPickupState createState() => OrderPickupState();
}

class OrderPickupState extends State<OrderPickup> {
  TextEditingController _contactNameController;
  CustomTimePicker _customTimePicker;
  OrderPickupBloc _orderPickupBloc;

  @override
  void initState() {
    super.initState();
    _contactNameController = TextEditingController();
    _contactNameController.addListener(_onContactNameChange);
    _orderPickupBloc = OrderPickupBloc();
    _customTimePicker =
        CustomTimePicker(currentTime: _orderPickupBloc.initialDate());
  }

  @override
  void dispose() {
    _contactNameController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  void _onContactNameChange() {
    _orderPickupBloc.setContactName(_contactNameController.text);
  }

  Result<PickupInfoData> pickupInfoData() {
    return _orderPickupBloc.validateAndReturnPickupInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CardView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                _orderPickupBloc.pageTitle(),
                style: AppTheme.title,
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: _contactNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    counter: const SizedBox(),
                    contentPadding: const EdgeInsets.fromLTRB(0, 8, 16, 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.green)),
                    hintStyle: AppTheme.hintText,
                    hintText: _orderPickupBloc.contactHintText()),
              )),
          TappableCard(
              iconData: Icons.date_range,
              displayText: _orderPickupBloc.pickupDateDisplayString(),
              actionText: _orderPickupBloc.actionText(),
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: _orderPickupBloc.initialDate(),
                  maxTime: _orderPickupBloc.maxDate(),
                  currentTime: _orderPickupBloc.pickupDate(),
                  locale: _orderPickupBloc.locale(),
                  onConfirm: (date) {
                    _orderPickupBloc.setPickupDate(date);
                    setState(
                      () {},
                    );
                  },
                );
              }),
          const SizedBox(
            height: 10.0,
          ),
          TappableCard(
              iconData: Icons.access_time,
              displayText: _orderPickupBloc.pickupTimeDisplayString(),
              actionText: _orderPickupBloc.actionText(),
              onPressed: () {
                DatePicker.showPicker(context,
                    showTitleActions: true,
                    locale: _orderPickupBloc.locale(),
                    pickerModel: _customTimePicker, onConfirm: (time) {
                  if (isNull(time)) {
                    _showMessage('Invalid time selected');
                    return;
                  }
                  _orderPickupBloc.setPickupTime(time);
                  setState(() {});
                });
              }),
          const SizedBox(
            height: 16.0,
          ),
        ]));
  }
}
