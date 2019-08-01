import 'package:authentication_view/auth_colors.dart';
import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:authentication_view/authentication_view.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AuthenticationView(buttonText: 'LOGIN', headerLayout: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Login', style: TextStyle(fontWeight: FontWeight.w700, color: AuthColors.text_black), textScaleFactor: 2.5),
          Icon(Icons.verified_user, color: AuthColors.green)
        ],
      ),screenType: ScreenType.LOGIN, fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD], onValidation: (bool isValidationSuccess, List<String> fieldValues) {
        if (isValidationSuccess) {
          debugPrint("email and password fields are " + fieldValues[0] + fieldValues[1]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreen()));
        }
      }),
    );
  }
}