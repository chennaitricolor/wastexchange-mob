import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:authentication_view/single_field_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleFieldView(
        titleLayout: const Text(Constants.OTP_TITLE, style: TextStyle(fontSize: 20, color: AppColors.text_black)),
          messageLayout: Container(margin: const EdgeInsets.symmetric(vertical: 24), child: Text(Constants.OTP_MESSAGE, style: TextStyle(fontSize: 16, color: AppColors.grey))),
          fieldStyle: FieldStyle.value(0, 8, 24, const EdgeInsets.all(36),
              AppColors.underline, AppColors.green, AppColors.text_grey),
          fieldValidator: (value) =>
              FieldValidator.validateEmailAddress(value),
          headerLayout: HomeAppBar(),
          fieldType: const FieldType.value(Constants.FIELD_OTP, 6, TextInputType.number, false),
          onValidation: (bool isValidationSuccess, String emailValue) {}),
    );
  }
}
