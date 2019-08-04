import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginView(
          placeHolderBelowButton: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()));
              },
              child: RichText(text: TextSpan(text: Constants.LOGIN_NOT_MEMBER,
                  style: TextStyle(color: AppColors.text_grey), children: <TextSpan>[
                    TextSpan(text: Constants.SIGNUP_BUTTON, style: TextStyle(color: AppColors.green))
                  ]))),
          placeHolderAboveButton: MaterialButton(
              onPressed: () {},
              child: Text(Constants.LOGIN_FORGOT_PASSWORD,
                  style: TextStyle(color: AppColors.text_grey))),
          fieldStyle: FieldStyle.value(0, 8, 24, const EdgeInsets.all(36),
              AppColors.underline, AppColors.green, AppColors.text_grey),
          field1Validator: (value) =>
              FieldValidator.validateEmailAddress(value),
          field2Validator: (value) => FieldValidator.validatePassword(value),
          headerLayout: HomeAppBar(),
          fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD],
          onValidation: (bool isValidationSuccess, String emailValue,
              String passwordValue) {
            if (!isValidationSuccess) {
              return;
            }
            UserClient()
                .login(LoginData(loginId: emailValue, password: passwordValue))
                .then((response) {
              if (response.success) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapScreen()));
              }
            });
          }),
    );
  }
}
