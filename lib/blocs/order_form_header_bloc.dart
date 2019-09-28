import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

class OrderFormHeaderBloc {
  OrderPickupBloc() {
    final DateTime nowPlus18Hours =
        DateTime.now().add(Duration(hours: minimumPickupTimeHoursFromNow));
    _initialDate =
        DateTime(nowPlus18Hours.year, nowPlus18Hours.month, nowPlus18Hours.day);
  }

  int minimumPickupTimeHoursFromNow = 18;

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

  Result<PickupInfoData> validateAndReturnPickupInfo() {
    final List<String> arr = [];
    if (isNull(_contactName) || _contactName.isEmpty) {
      arr.add('Contact Name cannot be empty');
    }
    if (isNull(_pickupDate)) {
      arr.add('Pickup Date not selected');
    }
    if (isNull(_pickupTime)) {
      arr.add('Pickup Time not selected');
    }
    if (isNotNull(_pickupDate) &&
        isNotNull(_pickupTime) &&
        !_isPickDateTimeAfterMinimumHoursFromNow()) {
      arr.add(
          'Pickup Time should be after $minimumPickupTimeHoursFromNow hours from now');
    }
    if (arr.isNotEmpty) {
      return Result.error(arr.join('\n'));
    }
    return Result.completed(PickupInfoData(
        contactName: _contactName, pickupDate: pickupDateAndTime()));
  }

  bool _isPickDateTimeAfterMinimumHoursFromNow() {
    ArgumentError.checkNotNull(_pickupDate);
    ArgumentError.checkNotNull(_pickupTime);
    final currentDateTime = DateTime.now();
    final pickupDateTime = pickupDateAndTime();
    return pickupDateTime.difference(currentDateTime).inMinutes >
        minimumPickupTimeHoursFromNow * 60;
  }

  DateTime initialDate() => _initialDate;

  DateTime pickupDate() => _pickupDate ?? _initialDate;

  DateTime maxDate() => DateTime(2022, 12, 31);

  DateTime pickupDateAndTime() => DateTime(
      _pickupDate.year,
      _pickupDate.month,
      _pickupDate.day,
      _pickupTime.hour,
      _pickupTime.minute,
      _pickupTime.second);

  LocaleType locale() => LocaleType.en;

  String actionText() => 'Change';

  String pageTitle() => 'Pickup Details';

  String contactHintText() => 'Contact Name';
}
