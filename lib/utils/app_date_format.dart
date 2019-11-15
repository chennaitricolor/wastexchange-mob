import 'package:intl/intl.dart';

class AppDateFormat {
  static const String defaultDateFormat = 'dd MMM yyyy';
  static const String defaultTimeFormat = 'h:mm a';
  static const String shortDateFormat = 'dd MMM';

  static String getFormattedDefaultDateTime(DateTime date) {
    final format = DateFormat(
        '${AppDateFormat.defaultDateFormat} ${AppDateFormat.defaultTimeFormat}');
    return format.format(date.toLocal());
  }
}
