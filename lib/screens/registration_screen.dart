import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/otp_bloc.dart';
import 'package:wastexchange_mobile/models/api_response.dart';
import 'package:wastexchange_mobile/models/otp_data.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/display_util.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  OtpBloc _bloc;

  @override
  void initState() {
    _bloc = OtpBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationView(
        fieldStyle: FieldStyle.value(0, 8, 24, 24,
            AppColors.underline, AppColors.green, AppColors.text_grey),
        headerLayout: HomeAppBar(),
        fieldValidator: (value, index) {},
        fieldTypes: [
          FieldType.NAME,
          const FieldType.value(Constants.FIELD_ADDRESS, 30, TextInputType.text, false),
          const FieldType.value(Constants.FIELD_CITY, 20, TextInputType.text, false),
          const FieldType.value(Constants.FIELD_PINCODE, 6, TextInputType.number, false),
          FieldType.MOBILE,
          const FieldType.value(
              Constants.FIELD_ALTERNATE_NUMBER, 10, TextInputType.phone, false),
          FieldType.EMAIL,
          FieldType.PASSWORD,
          FieldType.CONFIRM_PASSWORD
        ],
        onValidation: (bool isValidationSuccess, textEditingControllers) {
            sendOtp(
                textEditingControllers[4].text, textEditingControllers[6].text);
        },
      ),
    );
  }

  void sendOtp(String mobile, String email) {
    OtpData otpData = OtpData(emailId: email, mobileNo: mobile);
    _bloc.sendOtp(otpData);
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
                context, MaterialPageRoute(builder: (context) => OTPScreen()));
          }
          break;
      }
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
