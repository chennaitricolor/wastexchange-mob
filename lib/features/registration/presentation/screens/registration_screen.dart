import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/button_style.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/features/otp/presentation/screens/otp_screen.dart';
import 'package:wastexchange_mobile/core/utils/app_colors.dart';
import 'package:wastexchange_mobile/core/utils/app_logger.dart';
import 'package:wastexchange_mobile/core/utils/app_theme.dart';
import 'package:wastexchange_mobile/core/utils/constants.dart';
import 'package:wastexchange_mobile/core/utils/field_validator.dart';
import 'package:wastexchange_mobile/core/utils/locale_constants.dart';
import 'package:wastexchange_mobile/core/widgets/home_app_bar.dart';
import 'package:wastexchange_mobile/core/dialogs/dialog_util.dart';


class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  OtpBloc _bloc;
  RegistrationData _registrationData;
  double _latitude = 0;
  double _longitude = 0;
  final _logger = AppLogger.get('RegistrationScreen');

  final FieldType _name = FieldType.value(
      Constants.ID_NAME, Constants.FIELD_NAME, 30, TextInputType.text, false);
  final FieldType _mobile = FieldType.value(Constants.ID_MOBILE,
      Constants.FIELD_MOBILE, 10, TextInputType.phone, false);
  final FieldType _confirmPassword = FieldType.value(
      Constants.ID_CONFIRM_PASSWORD,
      Constants.FIELD_CONFIRM_PASSWORD,
      15,
      TextInputType.text,
      true);
  final FieldType _address = FieldType.value(Constants.ID_ADDRESS,
      Constants.FIELD_ADDRESS, 30, TextInputType.text, false);
  final FieldType _city = FieldType.value(
      Constants.ID_CITY, Constants.FIELD_CITY, 20, TextInputType.text, false);
  final FieldType _pincode = FieldType.value(Constants.ID_PINCODE,
      Constants.FIELD_PINCODE, 6, TextInputType.number, false);
  final FieldType _alternateNumber = FieldType.value(
      Constants.ID_ALTERNATE_NUMBER,
      Constants.FIELD_ALTERNATE_NUMBER,
      10,
      TextInputType.phone,
      false);

  @override
  void initState() {
    _initCurrentLocation();

    _bloc = OtpBloc();
    _bloc.otpStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          _showMessage(Constants.REGISTRATION_FAILED);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          _showOTPScreen();
          break;
      }
    });
    super.initState();
  }

  void _showMessage(String message) {
    Flushbar(
        forwardAnimationCurve: Curves.ease,
        duration: const Duration(seconds: 2),
        message: message)
      ..show(context);
  }

  void _showOTPScreen() {
    Router.pushNamed(
      context,
      OTPScreen.routeName,
      arguments: _registrationData,
    );
  }

  void _initCurrentLocation() {
    // TODO(Sayeed): [Sayeed] Can we move this as a new stream to the bloc
    Geolocator()
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          _latitude = position != null ? position.latitude : 0;
          _longitude = position != null ? position.longitude : 0;
          _logger.d('Latitude: ' + _latitude.toString());
          _logger.d('Longitude: ' + _longitude.toString());
        }
      }).catchError((e) {
        _logger.d(e.toString());
        _latitude = 0;
        _longitude = 0;
      });
  }

  @override
  Widget build(BuildContext context) {
    final String localeEmailId =
        AppLocalizations.of(context).translate(LocaleConstants.EMAIL_FIELD);
    final String localePasswordText =
        AppLocalizations.of(context).translate(LocaleConstants.PASSWORD_FIELD);
    final FieldType _email = FieldType.value(Constants.ID_EMAIL, localeEmailId,
        50, TextInputType.emailAddress, false);
    final FieldType _password = FieldType.value(Constants.ID_PASSWORD,
        localePasswordText, 15, TextInputType.text, true);

    return Scaffold(
        body: AuthenticationView(
      buttonTextStyle: AppTheme.buttonTitle,
      buttonStyle:
          ButtonStyle.value(240, 55, 55, AppColors.green, Colors.white),
      fieldStyle: FieldStyle.value(0, 8, 24, 24, AppColors.underline,
          AppColors.green, AppColors.text_grey),
      headerLayout: HomeAppBar(onBackPressed: () {
        Navigator.pop(context, false);
      }),
      fieldValidator: (idAsKey, values) {
        final String value = values[idAsKey].trim();
        switch (idAsKey) {
          case Constants.ID_NAME:
            return FieldValidator.validateName(value);
          case Constants.ID_MOBILE:
            return FieldValidator.validateMobileNumber(value);
          case Constants.ID_ALTERNATE_NUMBER:
            final String mobile = values[Constants.ID_MOBILE];
            return FieldValidator.validateAlternateMobileNumber(value, mobile);
          case Constants.ID_PINCODE:
            return FieldValidator.validatePincode(value);
          case Constants.ID_CITY:
            return FieldValidator.validateCity(value);
          case Constants.ID_ADDRESS:
            return FieldValidator.validateAddress(value);
          case Constants.ID_CONFIRM_PASSWORD:
            return FieldValidator.validateConfirmPassword(
                values[Constants.ID_PASSWORD], value);
          case Constants.ID_EMAIL:
            return FieldValidator.validateEmailAddress(value);
          case Constants.ID_PASSWORD:
            return FieldValidator.validatePassword(value);
        }
        return null;
      },
      fieldTypes: [
        _name,
        _address,
        _city,
        _pincode,
        _mobile,
        _alternateNumber,
        _email,
        _password,
        _confirmPassword
      ],
      onValidation: (bool isValidationSuccess, valueMap) {
        if (!isValidationSuccess) {
          return;
        }
        if (_latitude == 0 && _longitude == 0) {
          _showMessage(
              'Location should be enabled to proceed with registration. Please go to Settings > Location and enable location access for this app.');
          return;
        }
        sendOtp(valueMap);
      },
    ));
  }

// TODO(Sayeed): Move this to bLoc
  void sendOtp(Map<String, String> valueMap) {
    final name = valueMap[Constants.ID_NAME];
    final address = valueMap[Constants.ID_ADDRESS];
    final city = valueMap[Constants.ID_CITY];
    final pincode = valueMap[Constants.ID_PINCODE] != null
        ? int.parse(valueMap[Constants.ID_PINCODE])
        : 0;
    final int mobile = valueMap[Constants.ID_MOBILE] != null
        ? int.parse(valueMap[Constants.ID_MOBILE])
        : 0;
    final int alternateNumber = valueMap[Constants.ID_ALTERNATE_NUMBER] != null
        ? int.parse(valueMap[Constants.ID_ALTERNATE_NUMBER])
        : 0;
    final email = valueMap[Constants.ID_EMAIL];
    final password = valueMap[Constants.ID_PASSWORD];

    _registrationData = RegistrationData(
        name: name,
        address: address,
        city: city,
        pinCode: pincode,
        mobNo: mobile,
        altMobNo: alternateNumber,
        emailId: email,
        password: password,
        lat: _latitude,
        long: _longitude,
        persona: 'buyer');

    final OtpData otpData =
        OtpData(emailId: email, mobileNo: mobile.toString());
    _bloc.sendOtp(otpData);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
