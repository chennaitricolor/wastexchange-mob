import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:authentication_view/registration_view.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegistrationView(
        fieldStyle: FieldStyle.value(0, 8, 24, const EdgeInsets.all(24),
            AppColors.underline, AppColors.green, AppColors.text_grey),
        field1Validator: (value) => FieldValidator.validateEmailAddress(value),
        field2Validator: (value) => FieldValidator.validatePassword(value),
        headerLayout: HomeAppBar(),
        fieldTypes: [
          FieldType.NAME,
          const FieldType.value('Address', 30, TextInputType.text, false),
          const FieldType.value('City', 20, TextInputType.text, false),
          const FieldType.value('Pincode', 6, TextInputType.number, false),
          FieldType.MOBILE,
          const FieldType.value(
              'Alternate Number', 10, TextInputType.phone, false),
          FieldType.EMAIL,
          FieldType.PASSWORD,
          FieldType.CONFIRM_PASSWORD
        ],
        onValidation: (bool isValidationSuccess, List<String> values) {
          if (isValidationSuccess) {
            debugPrint('validation success');
          } else {
            debugPrint('validation failure');
          }
        },
      ),
    );
  }
}
