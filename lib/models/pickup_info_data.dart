import 'package:flutter/material.dart';

class PickupInfoData {
  PickupInfoData(
      {@required this.pickupDate,
      @required this.pickupTime,
      @required this.contactName});
  final DateTime pickupTime;
  final DateTime pickupDate;
  final String contactName;

  DateTime get pickupDateTime {
    return DateTime(pickupDate.year, pickupDate.month, pickupDate.day,
        pickupTime.hour, pickupTime.minute, pickupTime.second);
  }
}
