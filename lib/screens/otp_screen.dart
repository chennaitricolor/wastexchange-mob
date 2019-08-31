import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/otp_bloc.dart';
import 'package:wastexchange_mobile/blocs/registration_bloc.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(this._registrationData);
  static const routeName = '/otpScreen';

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
  final logger = AppLogger.get('OTPScreen');

  @override
  void initState() {
    _initOtpBloc();
    _initRegistrationBloc();
    super.initState();
  }

  // TODO(Sayeed): Combine _otpBloc, _registration blocs
  void _initOtpBloc() {
    _otpBloc = OtpBloc();
    _otpBloc.otpStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          _showToast(Constants.SEND_OTP_FAIL);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          _showToast(Constants.SEND_OTP_SUCCESS);
          break;
      }
    });
  }

  void _initRegistrationBloc() {
    _registrationBloc = RegistrationBloc();
    _registrationBloc.registrationStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          _showToast(Constants.REGISTRATION_FAILED);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          _showMap();
          break;
      }
    });
  }

  void _showToast(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showMap() {
    Router.pushReplacementNamed(context, MapScreen.routeName);
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
