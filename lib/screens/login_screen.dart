import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/resources/api_provider.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:authentication_view/authentication_view.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AuthenticationView(screenType: ScreenType.LOGIN, fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD], onValidation: (bool isValidationSuccess, List<String> fieldValues) {
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