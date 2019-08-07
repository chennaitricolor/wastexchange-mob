import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/screens/forgot_password_screen.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
          placeHolderBelowButton: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              },
              child: RichText(
                  text: TextSpan(
                      text: Constants.LOGIN_NOT_MEMBER,
                      style: TextStyle(color: AppColors.text_grey),
                      children: <TextSpan>[
                    TextSpan(
                        text: Constants.SIGNUP_BUTTON,
                        style: TextStyle(color: AppColors.green))
                  ]))),
          placeHolderAboveButton: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
              },
              child: Text(Constants.LOGIN_FORGOT_PASSWORD,
                  style: TextStyle(color: AppColors.text_grey))),
          fieldStyle: FieldStyle.value(16, 8, 24, 36,
              AppColors.underline, AppColors.green, AppColors.text_grey),
          fieldValidator: (value, index) {
            switch(index){
              case 0:
                return FieldValidator.validateEmailAddress(value);
              case 1:
                return FieldValidator.validatePassword(value);
              default:
                return null;
            }
          },
          headerLayout: HomeAppBar(),
          fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD],
          onValidation: (isValidationSuccess, textEditingControllers) {
            if (!isValidationSuccess) {
              return;
            }
            UserClient()
                .login(LoginData(loginId: textEditingControllers[0].text, password: textEditingControllers[1].text))
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
