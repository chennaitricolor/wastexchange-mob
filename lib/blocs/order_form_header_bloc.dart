import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/pickup_info_data_store.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

// TODO(Sayeed): Split this class by responsibility. We can separate state management, dateTime, UI
class OrderFormHeaderBloc {
  OrderFormHeaderBloc(
      {@required PickupInfoData pickupInfoData,
      PickupInfoDatastore pickupInfoDataStore}) {
    final DateTime nowPlusMinimumHours = DateTime.now()
        .add(const Duration(hours: _minimumPickupTimeHoursFromNow));
    _initialDate = DateTime(nowPlusMinimumHours.year, nowPlusMinimumHours.month,
        nowPlusMinimumHours.day);
    _pickupInfoDatastore = pickupInfoDataStore ?? PickupInfoDatastore();
    if (isNotNull(pickupInfoData)) {
      _populateSavedData(pickupInfoData);
    }
  }

  static const int _minimumPickupTimeHoursFromNow = 18;

  PickupInfoDatastore _pickupInfoDatastore;
  DateTime _initialDate;
  DateTime _pickupDate;
  DateTime _pickupTime;
  String _contactName;

  void setPickupDate(DateTime date) {
    ArgumentError.checkNotNull(date);
    _pickupDate = date.toUtc();
  }

  void setPickupTime(DateTime time) {
    // TODO(Sayeed): Move to assert pattern
    ArgumentError.checkNotNull(time);
    // TODO(Sayeed): This timezone conversion should move to domain layer i.e. repository
    _pickupTime = time.toUtc();
  }

  void setContactName(String name) {
    _contactName = name.trim();
  }

  String get pickupDateDisplayString {
    if (isNull(_pickupDate)) {
      return 'Pickup Date';
    }
    final f = DateFormat(AppDateFormat.defaultDateFormat);
    return f.format(_pickupDate.toLocal());
  }

  String get pickupTimeDisplayString {
    if (isNull(_pickupTime)) {
      return 'Pickup Time';
    }
    final f = DateFormat(AppDateFormat.defaultTimeFormat);
    return f.format(_pickupTime.toLocal());
  }

  String get contactName {
    return _contactName;
  }

  Result<PickupInfoData> validatedPickupInfo() {
    final List<String> arr = [];
    final isContactNameValid = _isContactNameValid(_contactName);
    if (isNotNull(isContactNameValid)) {
      arr.add(isContactNameValid);
    }
    if (isNull(_pickupDate)) {
      arr.add('Please select Pickup Date');
    }
    if (isNull(_pickupTime)) {
      arr.add('Please select Pickup Time');
    }
    if (isNotNull(_pickupDate) &&
        isNotNull(_pickupTime) &&
        !_isPickDateTimeAfterMinimumHoursFromNow()) {
      arr.add(minimumPickupDateTimeHoursFromNowMessage());
    }
    if (arr.isNotEmpty) {
      return Result.error(arr.join('\n'));
    }
    return Result.completed(PickupInfoData(
        contactName: _contactName,
        pickupDate: _pickupDate,
        pickupTime: _pickupTime));
  }

  bool _isPickDateTimeAfterMinimumHoursFromNow() {
    ArgumentError.checkNotNull(_pickupDate);
    ArgumentError.checkNotNull(_pickupTime);
    final currentDateTime = DateTime.now();
    final pickupDateTime = pickupDateAndTime();
    return pickupDateTime.difference(currentDateTime).inMinutes >
        _minimumPickupTimeHoursFromNow * 60;
  }

  void saveData() {
    _pickupInfoDatastore.saveData(PickupInfoData(
        contactName: _contactName,
        // TODO(Sayeed): Fix this code later. Doing it in release pressure. Will revisit.
        pickupDate: isNotNull(_pickupDate) ? _pickupDate.toUtc() : null,
        pickupTime: isNotNull(_pickupTime) ? _pickupTime.toUtc() : null));
  }

  void clearSavedData() {
    _pickupInfoDatastore.clearData();
  }

  void _populateSavedData(PickupInfoData pickupInfoData) {
    if (!isNullOrEmpty(pickupInfoData.contactName)) {
      _contactName = pickupInfoData.contactName;
    }
    if (isNotNull(pickupInfoData.pickupDate)) {
      _pickupDate = pickupInfoData.pickupDate.toUtc();
    }
    if (isNotNull(pickupInfoData.pickupTime)) {
      _pickupTime = pickupInfoData.pickupTime.toUtc();
    }
  }

  String _isContactNameValid(String contactName) {
    if (isNullOrEmpty(contactName)) {
      return 'Please add Contact Name';
    }
    return FieldValidator.validateName(contactName);
  }

  DateTime initialDate() => _initialDate;

  DateTime pickupDate() {
    print(_pickupDate);
    print(_initialDate);
    return _pickupDate ?? _initialDate;
  }

  DateTime maxDate() => _initialDate.add(const Duration(days: 5));

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

  String invalidDateTimeText() => 'Invalid time selected';

  String minimumPickupDateTimeHoursFromNowMessage() =>
      'Pickup DateTime should be after $_minimumPickupTimeHoursFromNow hours from now';
}
