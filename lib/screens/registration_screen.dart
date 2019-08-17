import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:authentication_view/space.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wastexchange_mobile/blocs/otp_bloc.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/util/logger.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:wastexchange_mobile/widgets/user_type_selector.dart';
import 'package:wastexchange_mobile/widgets/widget_display_util.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  OtpBloc _bloc;
  RegistrationData registrationData;
  double latitude = 0;
  double longitude = 0;
  final logger = getLogger('RegistrationScreen');

  final FieldType _name =
      FieldType.value(Constants.FIELD_NAME, 30, TextInputType.text, false);
  final FieldType _email = FieldType.value(
      Constants.FIELD_EMAIL, 50, TextInputType.emailAddress, false);
  final FieldType _mobile =
      FieldType.value(Constants.FIELD_MOBILE, 10, TextInputType.phone, false);
  final FieldType _password =
      FieldType.value(Constants.FIELD_PASSWORD, 15, TextInputType.text, true);
  final FieldType _confirmPassword = FieldType.value(
      Constants.FIELD_CONFIRM_PASSWORD, 15, TextInputType.text, true);
  final FieldType _address =
      FieldType.value(Constants.FIELD_ADDRESS, 30, TextInputType.text, false);
  final FieldType _city =
      FieldType.value(Constants.FIELD_CITY, 20, TextInputType.text, false);
  final FieldType _pincode =
      FieldType.value(Constants.FIELD_PINCODE, 6, TextInputType.number, false);
  final FieldType _alternateNumber = FieldType.value(
      Constants.FIELD_ALTERNATE_NUMBER, 10, TextInputType.phone, false);

  UserType userType = UserType.BUYER;

  @override
  void initState() {
    _initCurrentLocation();
    _bloc = OtpBloc();
    _bloc.otpStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          DisplayUtil.instance.showLoadingDialog(context);
          break;
        case Status.ERROR:
          DisplayUtil.instance.dismissDialog(context);
          break;
        case Status.COMPLETED:
          if (_snapshot.data.message.isNotEmpty) {
            DisplayUtil.instance.dismissDialog(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPScreen(registrationData)));
          }
          break;
      }
    });
    super.initState();
  }

  void _initCurrentLocation() {
    // TODO(Sayeed): [Sayeed] Can we move this as a new stream to the bloc
    Geolocator()
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          latitude = position != null ? position.latitude : 0;
          longitude = position != null ? position.longitude : 0;
          logger.d('Latitude: ' + latitude.toString());
          logger.d('Longitude: ' + longitude.toString());
        }
      }).catchError((e) {
        logger.d(e.toString());
        latitude = 0;
        longitude = 0;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthenticationView(
      placeHolderAboveButton:
          UserTypeSelector(onValueChanged: (UserType userType) {
        this.userType = userType;
        logger.i(userType.toString());
      }),
      placeHolderBelowButton: Space(24),
      fieldStyle: FieldStyle.value(0, 8, 24, 24, AppColors.underline,
          AppColors.green, AppColors.text_grey),
      headerLayout: HomeAppBar(),
      fieldValidator: (hintAsKey, values) {
        final String value = values[hintAsKey];
        switch (hintAsKey) {
          case Constants.FIELD_NAME:
            return FieldValidator.validateName(value);
          case Constants.FIELD_MOBILE:
            return FieldValidator.validateMobileNumber(value);
          case Constants.FIELD_ALTERNATE_NUMBER:
            return FieldValidator.validateMobileNumber(value);
          case Constants.FIELD_PINCODE:
            return FieldValidator.validatePincode(value);
          case Constants.FIELD_CITY:
            return FieldValidator.validateCity(value);
          case Constants.FIELD_ADDRESS:
            return FieldValidator.validateAddress(value);
          case Constants.FIELD_EMAIL:
            return FieldValidator.validateEmailAddress(value);
          case Constants.FIELD_PASSWORD:
            return FieldValidator.validatePassword(value);
          case Constants.FIELD_CONFIRM_PASSWORD:
            return FieldValidator.validateConfirmPassword(
                values[Constants.FIELD_PASSWORD], value);
          default:
            return null;
        }
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
          if (latitude == 0 && longitude == 0) {
            DisplayUtil.instance.showErrorDialog(context,
                'Location should be enabled to proceed with the registration');
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
    final email = valueMap[Constants.FIELD_EMAIL];
    final password = valueMap[Constants.FIELD_PASSWORD];
    final String persona = (userType == UserType.BUYER) ? 'buyer' : 'seller';

    registrationData = RegistrationData(
        name: name,
        address: address,
        city: city,
        pinCode: pincode,
        mobNo: mobile,
        altMobNo: alternateNumber,
        emailId: email,
        password: password,
        lat: latitude,
        long: longitude,
        persona: persona);

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
