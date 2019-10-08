import 'package:intl/intl.dart';

class AppDateFormat {
  static const String defaultDateFormat = 'dd MMM yyyy';
  static const String defaultTimeFormat = 'h:mm a';
  static const String shortDateFormat = 'dd MMM';

  static String getFormattedDate(DateTime date) {
    final format = DateFormat(
        '${AppDateFormat.shortDateFormat} ${AppDateFormat.defaultTimeFormat}');
    return format.format(date.toLocal());
  }
}
