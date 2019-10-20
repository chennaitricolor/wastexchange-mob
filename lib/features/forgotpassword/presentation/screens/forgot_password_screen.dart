import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/core/utils/app_colors.dart';
import 'package:wastexchange_mobile/core/utils/app_theme.dart';
import 'package:wastexchange_mobile/core/utils/constants.dart';
import 'package:wastexchange_mobile/core/utils/field_validator.dart';
import 'package:wastexchange_mobile/core/utils/locale_constants.dart';
import 'package:wastexchange_mobile/core/widgets/home_app_bar.dart';

import '../../../../app_localizations.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgotPasswordScreen';

  @override
  Widget build(BuildContext context) {
    final String localeEmailId = 
        AppLocalizations.of(context).translate(LocaleConstants.EMAIL_FIELD);
    final FieldType _email = FieldType.value(Constants.ID_EMAIL, localeEmailId, 50, TextInputType.emailAddress, false);
    return Scaffold(
      body: AuthenticationView(
          buttonTextStyle: AppTheme.buttonTitle,
          buttonStyle: ButtonStyle.value(240, 55, 55, AppColors.green, Colors.white),
          messageLayout: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(24),
              child: Text(Constants.FORGOT_MESSAGE,
                  style: AppTheme.subtitle)),
          fieldStyle: FieldStyle.value(24, 8, 24, 36, AppColors.underline,
              AppColors.green, AppColors.text_grey),
          fieldValidator: (hintAsKey, valueMap) =>
              FieldValidator.validateEmailAddress(
                  valueMap[Constants.ID_EMAIL]),
          headerLayout: HomeAppBar(onBackPressed: () { Navigator.pop(context, false); }),
          fieldTypes: [_email],
          onValidation: (isValidationSuccess, textEditingControllers) {}),
    );
  }
}
