import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_date_format.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({this.date, this.hint});
  final DateTime date;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(hint, style: AppTheme.caption),
                const SizedBox(height: 4),
                Text(
                  AppDateFormat.getFormattedDefaultDateTime(date),
                  style: AppTheme.subtitle,
                )
              ]),
        ));
  }
}
