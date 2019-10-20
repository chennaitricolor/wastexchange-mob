import 'package:intl/intl.dart';
import 'package:wastexchange_mobile/models/pickup_info_data.dart';
import 'package:wastexchange_mobile/resources/key_value_data_store.dart';
import 'package:wastexchange_mobile/core/utils/app_date_format.dart';
import 'package:wastexchange_mobile/core/utils/global_utils.dart';

class PickupInfoDatastore {
  PickupInfoDatastore({KeyValueDataStoreInterface keyValueDataStore}) {
    _keyValueDataStore = keyValueDataStore ?? KeyValueDataStore();
  }

  static const String _kContactName = 'contact';
  static const String _kPickupDate = 'pickupDate';
  static const String _kPickupTime = 'pickupTime';
  static final DateFormat _persistenceDateFormat = DateFormat(
      '${AppDateFormat.defaultDateFormat} ${AppDateFormat.defaultTimeFormat}');

  KeyValueDataStoreInterface _keyValueDataStore;

  void saveData(PickupInfoData data) {
    if (_isContactNameValid(data.contactName)) {
      _keyValueDataStore.setString(data.contactName, _kContactName);
    }
    if (isNotNull(data.pickupDate)) {
      final String date =
          _persistenceDateFormat.format(data.pickupDate.toLocal());
      _keyValueDataStore.setString(date, _kPickupDate);
    }
    if (isNotNull(data.pickupTime)) {
      final String time =
          _persistenceDateFormat.format(data.pickupTime.toLocal());
      _keyValueDataStore.setString(time, _kPickupTime);
    }
  }

  void clearData() {
    [_kContactName, _kPickupDate, _kPickupTime]
        .forEach((k) => {_keyValueDataStore.remove(k)});
  }

  PickupInfoData getData() {
    String contactName;
    DateTime pickupDate;
    DateTime pickupTime;

    final String savedContactName = _keyValueDataStore.getString(_kContactName);
    if (_isContactNameValid(savedContactName)) {
      contactName = savedContactName;
    }

    final String date = _keyValueDataStore.getString(_kPickupDate);
    if (isNotNull(date)) {
      pickupDate = _persistenceDateFormat.parse(date);
    }

    final String time = _keyValueDataStore.getString(_kPickupTime);
    if (isNotNull(time)) {
      pickupTime = _persistenceDateFormat.parse(time);
    }

    return PickupInfoData(
        contactName: contactName,
        pickupDate: pickupDate,
        pickupTime: pickupTime);
  }

  bool _isContactNameValid(String contactName) =>
      !isNull(contactName) && contactName.isNotEmpty;
}
