import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomTimePicker extends CommonPickerModel {
  CustomTimePicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(0);
  }

  String digits(int value, int length) {
    return '$value'.padLeft(length, '0');
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 13) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 2) {
      return (index == 0) ? 'AM' : 'PM';
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return ':';
  }

  @override
  String rightDivider() {
    return ':';
  }

  @override
  List<int> layoutProportions() {
    return [2, 2, 1];
  }

  @override
  DateTime finalTime() {
    if (_is12AMSelected() || _is0PMSelected()) {
      return null;
    }

    final int pmOffset = _isPMSelected() ? 12 : 0;
    final int hour = currentLeftIndex() + pmOffset;
    final int minute = currentMiddleIndex();
    const int second = 0;

    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
            hour, minute, second)
        : DateTime(currentTime.year, currentTime.month, currentTime.day, hour,
            minute, second);
  }

  bool _is12AMSelected() =>
      currentLeftIndex() == 12 && currentRightIndex() == 0;

  bool _is0PMSelected() => currentLeftIndex() == 0 && currentRightIndex() == 1;

  bool _isPMSelected() => currentRightIndex() == 1;
}
