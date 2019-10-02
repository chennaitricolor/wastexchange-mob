import 'package:intl/intl.dart';

class AppDateFormat {
  static const String defaultDate = 'dd MMM yyyy';
  static const String defaultTime = 'h:mm a';
  static const String shortDate = 'dd MMM';

  static String getFormattedDate(DateTime date) {
    final format =
    DateFormat('${AppDateFormat.shortDate} ${AppDateFormat.defaultTime}');
    return format.format(date.toLocal());
  }
}
