import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:authentication_view/authentication_view.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AuthenticationView(screenType: ScreenType.LOGIN, fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD], onValidation: (bool isValidationSuccess) {
        if (isValidationSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreen()));
        }
      }),
    );
  }
}