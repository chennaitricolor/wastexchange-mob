import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class OrderPickupBloc {
  OrderPickupBloc() {
    _initialDate = DateTime.now().add(Duration(hours: 18));
  }
  DateTime _initialDate;
  DateTime _pickupDate;
  DateTime _pickupTime;
  String _contactName;

  void setPickupDate(DateTime date) {
    ArgumentError.checkNotNull(date);
    _pickupDate = date;
  }

  void setPickupTime(DateTime time) {
    ArgumentError.checkNotNull(time);
    _pickupTime = time;
  }

  void setContactName(String name) {
    _contactName = name;
  }

  String pickupDateDisplayString() {
    if (isNull(_pickupDate)) {
      return 'Pickup Date';
    }
    final f = DateFormat(AppDateFormat.defaultDate);
    return f.format(_pickupDate.toLocal());
  }

  String pickupTimeDisplayString() {
    if (isNull(_pickupTime)) {
      return 'Pickup Time';
    }
    final f = DateFormat(AppDateFormat.defaultTime);
    return f.format(_pickupTime.toLocal());
  }

  DateTime initialDate() => _initialDate;

  DateTime maxDate() => DateTime(2022, 12, 31);

  DateTime currentTime() => DateTime.now();

  LocaleType locale() => LocaleType.en;

  String actionText() => 'Change';

  String pageTitle() => 'Pickup Details';

  String contactHintText() => 'Contact Name';
}
