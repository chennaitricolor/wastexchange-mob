import 'package:authentication_view/field_type.dart';
import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/login_request.dart';
import 'package:wastexchange_mobile/resources/api_provider.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: LoginView(
          field1Validator: (value) =>
              FieldValidator.validateEmailAddress(value),
          field2Validator: (value) => FieldValidator.validatePassword(value),
          headerLayout: HomeAppBar(),
          fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD],
          onValidation: (bool isValidationSuccess, String emailValue, String passwordValue) {
            if (isValidationSuccess) {
              ApiProvider().login(LoginRequest(loginId: emailValue, password: passwordValue)).then((value) {
                if (value.auth) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen()));
                }
              });
            }
          }),
    );
  }
}
