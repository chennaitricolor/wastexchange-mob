import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wastexchange_mobile/blocs/order_pickup_bloc.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/commons/card_view.dart';
import 'package:wastexchange_mobile/widgets/custom_time_picker.dart';
import 'package:wastexchange_mobile/widgets/tappable_card.dart';

class OrderPickup extends StatefulWidget {
  @override
  _OrderPickup createState() => _OrderPickup();
}

class _OrderPickup extends State<OrderPickup> {
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

  void _onContactNameChange() {
    _orderPickupBloc.setContactName(_contactNameController.text);
  }

  @override
  void dispose() {
    _contactNameController.dispose();
    super.dispose();
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
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: _orderPickupBloc.initialDate(),
                    maxTime: _orderPickupBloc.maxDate(), onConfirm: (date) {
                  _orderPickupBloc.setPickupDate(date);
                  setState(
                    () {},
                  );
                },
                    currentTime: _orderPickupBloc.currentTime(),
                    locale: _orderPickupBloc.locale());
              }),
          const SizedBox(
            height: 10.0,
          ),
          TappableCard(
              iconData: Icons.access_time,
              displayText: _orderPickupBloc.pickupTimeDisplayString(),
              actionText: _orderPickupBloc.actionText(),
              onPressed: () {
                DatePicker.showPicker(context, showTitleActions: true,
                    onConfirm: (time) {
                  print('Confirm $time');
                  _orderPickupBloc.setPickupTime(time);
                  setState(() {});
                },
                    locale: _orderPickupBloc.locale(),
                    pickerModel: _customTimePicker);
                setState(() {});
              }),
          const SizedBox(
            height: 16.0,
          ),
        ]));
  }
}
