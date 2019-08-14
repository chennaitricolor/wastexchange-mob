import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/user_type_selector.dart';

class RadioButtonHorizontal extends StatelessWidget {
  UserType userType;
  UserType groupValue;
  String label;
  ValueChanged<UserType> onValueChanged;


  RadioButtonHorizontal({@required this.userType, @required this.groupValue, @required this.label,
      @required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return  FlatButton.icon(
      label: Text(label),
      icon: Radio(
        value: userType,
        groupValue: groupValue,
        onChanged: onValueChanged,
      ),
      onPressed: () {
        onValueChanged(userType);
      }
    );
  }
}
