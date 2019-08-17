import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/registration_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/widgets/widget_display_util.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/util/logger.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:authentication_view/authentication_view.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(this.registrationData);

  final RegistrationData registrationData;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  RegistrationBloc _bloc;
  RegistrationData registrationData;

  final logger = getLogger('OTPScreen');

  @override
  void initState() {
    registrationData = widget.registrationData;
    _bloc = RegistrationBloc();
    _bloc.registrationStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          DisplayUtil.instance.showLoadingDialog(context);
          break;
        case Status.ERROR:
          logger.i(_snapshot.message);
          DisplayUtil.instance.dismissDialog(context);
          break;
        case Status.COMPLETED:
          if (_snapshot.data.message.isNotEmpty) {
            logger.i(_snapshot.data.message);
            DisplayUtil.instance.dismissDialog(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MapScreen()));
          }
          break;
      }
    });
    super.initState();
  }

  void doRegister(String otp) {
    final int value = otp != null ? int.parse(otp) : 0;
    registrationData.otp = value;
    _bloc.register(registrationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
          titleLayout: Center(
              child: const Text(Constants.OTP_TITLE,
                  style: TextStyle(fontSize: 20, color: AppColors.text_black))),
          messageLayout: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(24),
              child: Text(Constants.OTP_MESSAGE,
                  style: TextStyle(fontSize: 16, color: AppColors.grey))),
          fieldStyle: FieldStyle.value(24, 8, 24, 36, AppColors.underline,
              AppColors.green, AppColors.text_grey),
          fieldValidator: (hintAsKey, values) {
            final String value = values[hintAsKey];
            switch (hintAsKey) {
              case Constants.FIELD_OTP:
                return FieldValidator.validateOTP(value);
              default:
                return null;
            }
          },
          headerLayout: HomeAppBar(),
          fieldTypes: [
            FieldType.value(
                Constants.FIELD_OTP, 10, TextInputType.number, false)
          ],
          onValidation: (isValidationSuccess, valueMap) {
            if (isValidationSuccess) {
              doRegister(valueMap[Constants.FIELD_OTP]);
            }
          }),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
