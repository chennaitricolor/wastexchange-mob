import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/resources/key_value_store.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/global_utils.dart';

// TODO(Sayeed): Split this class by responsibility. We can separate state management, dateTime, UI
class OrderFormHeaderBloc {
  OrderFormHeaderBloc(
      {@required restoreSavedData, KeyValueStoreInterface keyValueStore}) {
    final DateTime nowPlusMinimumHours = DateTime.now()
        .add(const Duration(hours: _minimumPickupTimeHoursFromNow));
    _initialDate = DateTime(nowPlusMinimumHours.year, nowPlusMinimumHours.month,
        nowPlusMinimumHours.day);
    _restoreSavedData = restoreSavedData;
    _keyValueStore = keyValueStore ?? KeyValueStore();
    if (_restoreSavedData) {
      _populateSaveDataInUI();
    }
  }

  bool _restoreSavedData;
  KeyValueStoreInterface _keyValueStore;

  static const int _minimumPickupTimeHoursFromNow = 18;
  static const String _kContactName = 'contact';
  static const String _kPickupDate = 'pickupDate';
  static const String _kPickupTime = 'pickupTime';
  static final DateFormat persistenceDateFormat =
      DateFormat('${AppDateFormat.defaultDate} ${AppDateFormat.defaultTime}');

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

  String get pickupDateDisplayString {
    if (isNull(_pickupDate)) {
      return 'Pickup Date';
    }
    final f = DateFormat(AppDateFormat.defaultDate);
    return f.format(_pickupDate.toLocal());
  }

  String get pickupTimeDisplayString {
    if (isNull(_pickupTime)) {
      return 'Pickup Time';
    }
    final f = DateFormat(AppDateFormat.defaultTime);
    return f.format(_pickupTime.toLocal());
  }

  String get contactName {
    return _contactName;
  }

  Result<PickupInfoData> validatedPickupInfo() {
    final List<String> arr = [];
    if (!isContactNameValid(_contactName)) {
      arr.add('Please add Contact Name');
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
        contactName: _contactName, pickupDate: pickupDateAndTime()));
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
    if (isContactNameValid(_contactName)) {
      _keyValueStore.setString(_contactName, _kContactName);
    }
    if (isNotNull(_pickupDate)) {
      final String date = persistenceDateFormat.format(_pickupDate.toLocal());
      _keyValueStore.setString(date, _kPickupDate);
    }
    if (isNotNull(_pickupTime)) {
      final String time = persistenceDateFormat.format(_pickupTime.toLocal());
      _keyValueStore.setString(time, _kPickupTime);
    }
  }

  void clearSavedData() {
    [_kContactName, _kPickupDate, _kPickupTime]
        .forEach((k) => {_keyValueStore.remove(k)});
  }

  void _populateSaveDataInUI() {
    final String savedContactName = _keyValueStore.getString(_kContactName);
    if (isContactNameValid(savedContactName)) {
      _contactName = savedContactName;
    }
    final String date = _keyValueStore.getString(_kPickupDate);
    if (isNotNull(date)) {
      _pickupDate = persistenceDateFormat.parse(date);
    }
    final String time = _keyValueStore.getString(_kPickupTime);
    if (isNotNull(time)) {
      _pickupTime = persistenceDateFormat.parse(time);
    }
  }

  bool isContactNameValid(String contactName) =>
      !isNull(contactName) && contactName.isNotEmpty;

  DateTime initialDate() => _initialDate;

  DateTime pickupDate() => _pickupDate ?? _initialDate;

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
