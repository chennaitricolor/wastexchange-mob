import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/views/user_type_selector.dart';

class RadioButtonHorizontal extends StatelessWidget {
  const RadioButtonHorizontal(
      {@required this.userType,
      @required this.groupValue,
      @required this.label,
      @required this.onValueChanged});

  final UserType userType;
  final UserType groupValue;
  final String label;
  final ValueChanged<UserType> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        label: Text(label),
        icon: Radio(
          value: userType,
          groupValue: groupValue,
          onChanged: onValueChanged,
        ),
        onPressed: () {
          onValueChanged(userType);
        });
  }
}
