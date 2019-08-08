import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
        titleLayout: Center(child: const Text(Constants.FORGOT_TITLE, style: TextStyle(fontSize: 20, color: AppColors.text_black))),
          messageLayout: Container(alignment: Alignment.center, margin: const EdgeInsets.all(24), child: Text(Constants.FORGOT_MESSAGE, style: TextStyle(fontSize: 16, color: AppColors.text_grey))),
          fieldStyle: FieldStyle.value(24, 8, 24, 36,
              AppColors.underline, AppColors.green, AppColors.text_grey),
          fieldValidator: (value, position) =>
              FieldValidator.validateEmailAddress(value),
          headerLayout: HomeAppBar(),
          fieldTypes: [FieldType.EMAIL],
          onValidation: (isValidationSuccess, textEditingControllers) {}),
    );
  }
}
