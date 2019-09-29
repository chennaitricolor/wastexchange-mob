import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wastexchange_mobile/blocs/order_form_header_bloc.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';
import 'package:wastexchange_mobile/widgets/views/card_view.dart';
import 'package:wastexchange_mobile/widgets/custom_time_picker.dart';
import 'package:wastexchange_mobile/widgets/tappable_card.dart';

class OrderFormHeader extends StatefulWidget {
  const OrderFormHeader({Key key}) : super(key: key);
  @override
  OrderFormHeaderState createState() => OrderFormHeaderState();
}

class OrderFormHeaderState extends State<OrderFormHeader> {
  TextEditingController _contactNameController;
  CustomTimePicker _customTimePicker;
  OrderFormHeaderBloc _orderFormHeaderBloc;

  @override
  void initState() {
    super.initState();
    _contactNameController = TextEditingController();
    _contactNameController.addListener(_onContactNameChange);
    _orderFormHeaderBloc = OrderFormHeaderBloc();
    _customTimePicker =
        CustomTimePicker(currentTime: _orderFormHeaderBloc.initialDate());
  }

  @override
  void dispose() {
    _contactNameController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: const Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  void _onContactNameChange() {
    _orderFormHeaderBloc.setContactName(_contactNameController.text);
  }

  Result<PickupInfoData> pickupInfoData() {
    return _orderFormHeaderBloc.validateAndReturnPickupInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CardView(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _orderFormHeaderBloc.pageTitle(),
              style: AppTheme.title,
            ),
            TextField(
              style: AppTheme.hintText,
              controller: _contactNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  counter: const SizedBox(),
                  contentPadding: const EdgeInsets.fromLTRB(0, 12, 16, 10),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.green)),
                  hintStyle: AppTheme.subtitle,
                  hintText: _orderFormHeaderBloc.contactHintText()),
            ),
            TappableCard(
                iconData: Icons.date_range,
                displayText: _orderFormHeaderBloc.pickupDateDisplayString(),
                actionText: _orderFormHeaderBloc.actionText(),
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: _orderFormHeaderBloc.initialDate(),
                    maxTime: _orderFormHeaderBloc.maxDate(),
                    currentTime: _orderFormHeaderBloc.pickupDate(),
                    locale: _orderFormHeaderBloc.locale(),
                    onConfirm: (date) {
                      _orderFormHeaderBloc.setPickupDate(date);
                      setState(
                        () {},
                      );
                    },
                  );
                }),
            TappableCard(
                iconData: Icons.access_time,
                displayText: _orderFormHeaderBloc.pickupTimeDisplayString(),
                actionText: _orderFormHeaderBloc.actionText(),
                onPressed: () {
                  DatePicker.showPicker(context,
                      showTitleActions: true,
                      locale: _orderFormHeaderBloc.locale(),
                      pickerModel: _customTimePicker, onConfirm: (time) {
                    if (isNull(time)) {
                      _showMessage('Invalid time selected');
                      return;
                    }
                    _orderFormHeaderBloc.setPickupTime(time);
                    setState(() {});
                  });
                }),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  '*${_orderFormHeaderBloc.minimumPickupDateTimeHoursFromNowMessage()}',
                  style: AppTheme.caption,
                )),
          ]),
    ));
  }
}
