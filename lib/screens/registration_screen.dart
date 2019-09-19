import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wastexchange_mobile/blocs/otp_bloc.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:wastexchange_mobile/widgets/views/user_type_selector.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';

import '../app_localizations.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FieldType _name =
      FieldType.value(Constants.ID_NAME, Constants.FIELD_NAME, 30, TextInputType.text, false);

  final FieldType _mobile =
      FieldType.value(Constants.ID_MOBILE, Constants.FIELD_MOBILE, 10, TextInputType.phone, false);

  final FieldType _confirmPassword = FieldType.value(
      Constants.ID_CONFIRM_PASSWORD, Constants.FIELD_CONFIRM_PASSWORD, 15, TextInputType.text, true);
  final FieldType _address =
      FieldType.value(Constants.ID_ADDRESS, Constants.FIELD_ADDRESS, 30, TextInputType.text, false);
  final FieldType _city =
      FieldType.value(Constants.ID_CITY, Constants.FIELD_CITY, 20, TextInputType.text, false);
  final FieldType _pincode =
      FieldType.value(Constants.ID_PINCODE, Constants.FIELD_PINCODE, 6, TextInputType.number, false);
  final FieldType _alternateNumber = FieldType.value(
      Constants.ID_ALTERNATE_NUMBER, Constants.FIELD_ALTERNATE_NUMBER, 10, TextInputType.phone, false);

  UserType userType = UserType.BUYER;

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
          _showToast(Constants.SEND_OTP_FAIL);
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          _showOTPScreen();
          break;
      }
    });
    super.initState();
  }

  void _showToast(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
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
    final FieldType _email =
        FieldType.value(Constants.ID_EMAIL, localeEmailId, 50, TextInputType.emailAddress, false);

    final FieldType _password =
        FieldType.value(Constants.ID_PASSWORD, localePasswordText, 15, TextInputType.text, true);

    return Scaffold(
        key: _scaffoldKey,
        body: AuthenticationView(
          fieldStyle: FieldStyle.value(0, 8, 24, 24, AppColors.underline,
              AppColors.green, AppColors.text_grey),
          headerLayout: HomeAppBar(onBackPressed: () {
            Navigator.pop(context, false);
          }),
          fieldValidator: (idAsKey, values) {
            final String value = values[idAsKey];
            switch (idAsKey) {
              case Constants.ID_NAME:
                return FieldValidator.validateName(value);
              case Constants.ID_MOBILE:
                return FieldValidator.validateMobileNumber(value);
              case Constants.ID_ALTERNATE_NUMBER:
                return FieldValidator.validateMobileNumber(value);
              case Constants.ID_PINCODE:
                return FieldValidator.validatePincode(value);
              case Constants.ID_CITY:
                return FieldValidator.validateCity(value);
              case Constants.ID_ADDRESS:
                return FieldValidator.validateAddress(value);
              case Constants.ID_CONFIRM_PASSWORD:
                return FieldValidator.validateConfirmPassword(
                    values[localePasswordText], value);
            }
            if (idAsKey == localeEmailId) {
              return FieldValidator.validateEmailAddress(value);
            } else if (idAsKey == localePasswordText) {
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
            if (isValidationSuccess) {
              if (_latitude == 0 && _longitude == 0) {
                showErrorDialog(context,
                    'Location should be enabled to proceed with registration');
              } else {
                sendOtp(valueMap);
              }
            }
          },
        ));
  }

  void sendOtp(Map<String, String> valueMap) {
    final name = valueMap[Constants.FIELD_NAME];
    final address = valueMap[Constants.FIELD_ADDRESS];
    final city = valueMap[Constants.FIELD_CITY];
    final pincode = valueMap[Constants.FIELD_PINCODE] != null
        ? int.parse(valueMap[Constants.FIELD_PINCODE])
        : 0;
    final int mobile = valueMap[Constants.FIELD_MOBILE] != null
        ? int.parse(valueMap[Constants.FIELD_MOBILE])
        : 0;
    final int alternateNumber =
        valueMap[Constants.FIELD_ALTERNATE_NUMBER] != null
            ? int.parse(valueMap[Constants.FIELD_ALTERNATE_NUMBER])
            : 0;
    final email = valueMap[
        AppLocalizations.of(context).translate(LocaleConstants.EMAIL_FIELD)];
    final password = valueMap[
        AppLocalizations.of(context).translate(LocaleConstants.PASSWORD_FIELD)];

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
