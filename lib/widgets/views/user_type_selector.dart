import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/views/radio_button_horizontal.dart';

enum UserType { BUYER, SELLER }

class UserTypeSelector extends StatefulWidget {
  const UserTypeSelector({@required this.onValueChanged});

  final ValueChanged<UserType> onValueChanged;

  @override
  _UserTypeSelectorState createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  UserType _userTypeValue = UserType.BUYER;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RadioButtonHorizontal(
              groupValue: _userTypeValue,
              userType: UserType.BUYER,
              label: 'Buyer',
              onValueChanged: (UserType value) {
                updateChanges(value);
                widget.onValueChanged(value);
              }),
          RadioButtonHorizontal(
              groupValue: _userTypeValue,
              userType: UserType.SELLER,
              label: 'Seller',
              onValueChanged: (UserType value) {
                updateChanges(value);
                widget.onValueChanged(value);
              }),
        ],
      ),
    );
  }

  void updateChanges(UserType value) {
    setState(() {
      _userTypeValue = value;
    });
  }
}
