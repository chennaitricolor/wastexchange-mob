import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:authentication_view/authentication_view.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class LoginScreen extends StatelessWidget {

  FieldValidator validator;

  LoginScreen() {
    validator = FieldValidator();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: AuthenticationView(
          field1Validator: (value) => validator.validateEmailAddress(value),
          field2Validator: (value) => validator.validatePassword(value),
          buttonText: Constants.LOGIN_BUTTON,
          headerLayout: HomeAppBar(),
          screenType: ScreenType.LOGIN,
          fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD],
          onValidation: (bool isValidationSuccess, List<String> fieldValues) {
            if (isValidationSuccess) {
              debugPrint("email and password fields are " +
                  fieldValues[0] +
                  fieldValues[1]);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapScreen()));
            }
          }),
    );
  }
}
