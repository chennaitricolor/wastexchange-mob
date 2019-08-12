import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/otp_bloc.dart';
import 'package:wastexchange_mobile/models/api_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/models/registration_data.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/display_util.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:geolocator/geolocator.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  OtpBloc _bloc;
  RegistrationData registrationData;
  double latitude;
  double longitude;

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
          debugPrint(_snapshot.message);
          DisplayUtil.instance.dismissDialog(context);
          break;
        case Status.COMPLETED:
          if (_snapshot.data.message.isNotEmpty) {
            debugPrint(_snapshot.data.message);
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
    Geolocator()
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          latitude =  position != null ? position.latitude : 0;
          longitude = position != null ? position.longitude : 0;
          debugPrint("Latitude: " + latitude.toString());
          debugPrint("Longitude: " + longitude.toString());
        }
      }).catchError((e) {
        latitude = 0;
        longitude = 0;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
        fieldStyle: FieldStyle.value(0, 8, 24, 24, AppColors.underline,
            AppColors.green, AppColors.text_grey),
        headerLayout: HomeAppBar(),
        fieldValidator: (value, index) {
          switch (index) {
            case 0:
              return FieldValidator.validateName(value);
            case 1:
              return FieldValidator.validateAddress(value);
            case 2:
              return FieldValidator.validateCity(value);
            case 3:
              return FieldValidator.validatePincode(value);
            case 4:
              return FieldValidator.validateMobileNumber(value);
            case 5:
              return FieldValidator.validateMobileNumber(value);
            case 6:
              return FieldValidator.validateEmailAddress(value);
            case 7:
              return FieldValidator.validatePassword(value);
            case 8:
                return FieldValidator.validatePassword(value);
            default:
              return null;
          }
        },
        fieldTypes: [
          FieldType.NAME,
          const FieldType.value(
              Constants.FIELD_ADDRESS, 30, TextInputType.text, false),
          const FieldType.value(
              Constants.FIELD_CITY, 20, TextInputType.text, false),
          const FieldType.value(
              Constants.FIELD_PINCODE, 6, TextInputType.number, false),
          FieldType.MOBILE,
          const FieldType.value(
              Constants.FIELD_ALTERNATE_NUMBER, 10, TextInputType.phone, false),
          FieldType.EMAIL,
          FieldType.PASSWORD,
          FieldType.CONFIRM_PASSWORD
        ],
        onValidation: (bool isValidationSuccess, textEditingControllers) {
          if(isValidationSuccess) {
            if(latitude == 0 && longitude == 0){
                DisplayUtil.instance.showErrorDialog(context, 'Location should be enabled to proceed with the registration');
            } else {
                sendOtp(textEditingControllers);
            }
          }
        },
      )
    );
  }

  void sendOtp(Map<int, TextEditingController> textEditingControllers) {
    final name = textEditingControllers[0].text;
    final address = textEditingControllers[1].text;
    final city = textEditingControllers[2].text;
    final pincode = textEditingControllers[3].text != null
        ? int.parse(textEditingControllers[3].text)
        : 0;
    final int mobile = textEditingControllers[4].text != null
        ? int.parse(textEditingControllers[4].text)
        : 0;
    final int alternateNumber = textEditingControllers[5].text != null
        ? int.parse(textEditingControllers[5].text)
        : 0;
    final email = textEditingControllers[6].text;
    final password = textEditingControllers[7].text;
    const persona = 'buyer';

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

    OtpData otpData = OtpData(emailId: email, mobileNo: mobile.toString());
    _bloc.sendOtp(otpData);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
