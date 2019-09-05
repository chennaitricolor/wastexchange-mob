import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgotPasswordScreen';

  final FieldType _email = FieldType.value(
      Constants.FIELD_EMAIL, 50, TextInputType.emailAddress, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
          messageLayout: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(24),
              child: Text(Constants.FORGOT_MESSAGE,
                  style: AppTheme.subtitle)),
          fieldStyle: FieldStyle.value(24, 8, 24, 36, AppColors.underline,
              AppColors.green, AppColors.text_grey),
          fieldValidator: (hintAsKey, valueMap) =>
              FieldValidator.validateEmailAddress(
                  valueMap[Constants.FIELD_EMAIL]),
          headerLayout: HomeAppBar(),
          fieldTypes: [_email],
          onValidation: (isValidationSuccess, textEditingControllers) {}),
    );
  }
}
