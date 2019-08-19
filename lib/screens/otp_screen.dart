import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/otp_bloc.dart';
import 'package:wastexchange_mobile/blocs/registration_bloc.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
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
  const OTPScreen(this._registrationData);

  final RegistrationData _registrationData;

  @override
  _OTPScreenState createState() => _OTPScreenState(_registrationData);
}

class _OTPScreenState extends State<OTPScreen> {
  _OTPScreenState(this._registrationData);

  RegistrationData _registrationData;
  RegistrationBloc _registrationBloc;
  OtpBloc _otpBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final logger = getLogger('OTPScreen');

  @override
  void initState() {
    _initOtpBloc();
    _initRegistrationBloc();
    super.initState();
  }

  void _initOtpBloc() {
    _otpBloc = OtpBloc();
    _otpBloc.otpStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          DisplayUtil.instance.showLoadingDialog(context);
          break;
        case Status.ERROR:
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: const Text(Constants.RESEND_OTP_FAIL)));
          DisplayUtil.instance.dismissDialog(context);
          break;
        case Status.COMPLETED:
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: const Text(Constants.RESEND_OTP_SUCCESS)));
          DisplayUtil.instance.dismissDialog(context);
          break;
      }
    });
  }

  void _initRegistrationBloc() {
    _registrationBloc = RegistrationBloc();
    _registrationBloc.registrationStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          DisplayUtil.instance.showLoadingDialog(context);
          break;
        case Status.ERROR:
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: const Text(Constants.REGISTRATION_FAILED)));
          DisplayUtil.instance.dismissDialog(context);
          break;
        case Status.COMPLETED:
          DisplayUtil.instance.dismissDialog(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MapScreen()));
          break;
      }
    });
  }

  void _doRegister(String otp) {
    final int value = otp != null ? int.parse(otp) : 0;
    _registrationData.otp = value;
    _registrationBloc.register(_registrationData);
  }

  void _sendOtp() {
    final OtpData data = OtpData(
        emailId: _registrationData.emailId,
        mobileNo: _registrationData.mobNo.toString());
    _otpBloc.sendOtp(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AuthenticationView(
          placeHolderBelowButton: MaterialButton(
              onPressed: () {
                _sendOtp();
              },
              child: RichText(
                  text: TextSpan(
                text: Constants.RESEND_OTP,
                style: TextStyle(color: AppColors.green),
              ))),
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
              _doRegister(valueMap[Constants.FIELD_OTP]);
            }
          }),
    );
  }

  @override
  void dispose() {
    _registrationBloc.dispose();
    _otpBloc.dispose();
    super.dispose();
  }
}
