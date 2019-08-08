import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
        fieldStyle: FieldStyle.value(0, 8, 24, 24,
            AppColors.underline, AppColors.green, AppColors.text_grey),
        headerLayout: HomeAppBar(),
        fieldValidator: (value, index) {},
        fieldTypes: [
          FieldType.NAME,
          const FieldType.value(Constants.FIELD_ADDRESS, 30, TextInputType.text, false),
          const FieldType.value(Constants.FIELD_CITY, 20, TextInputType.text, false),
          const FieldType.value(Constants.FIELD_PINCODE, 6, TextInputType.number, false),
          FieldType.MOBILE,
          const FieldType.value(
              Constants.FIELD_ALTERNATE_NUMBER, 10, TextInputType.phone, false),
          FieldType.EMAIL,
          FieldType.PASSWORD,
          FieldType.CONFIRM_PASSWORD
        ],
        onValidation: (bool isValidationSuccess, textEditingControllers) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OTPScreen()));
        },
      ),
    );
  }
}
