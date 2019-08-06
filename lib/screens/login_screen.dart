import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:authentication_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/login_bloc.dart';
import 'package:wastexchange_mobile/models/api_response.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/login_response.dart';
import 'package:wastexchange_mobile/screens/forgot_password_screen.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/util/app_colors.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loginViewLoaded = false;
  LoginBloc _bloc;
  LoginView _loginView;

  @override
  void didChangeDependencies() {
    _bloc = LoginBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loginViewLoaded) {
      _loginView = getLoginView(context);
      _loginViewLoaded = true;
    }
    return Scaffold(
        body: StreamBuilder<ApiResponse<LoginResponse>>(
            stream: _bloc.loginStream,
            builder: (_context, _snapshot) {
              if (_snapshot.hasData) {
                switch (_snapshot.data.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                    break;
                  case Status.ERROR:
                    return _loginView;
                    break;
                  case Status.COMPLETED:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapScreen()));
                    return Container();
                    break;
                }
              }
              return _loginView;
            }));
  }

  LoginView getLoginView(BuildContext context) {
    return LoginView(
        placeHolderBelowButton: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationScreen()));
            },
            child: RichText(
                text: TextSpan(
                    text: Constants.LOGIN_NOT_MEMBER,
                    style: TextStyle(color: AppColors.text_grey),
                    children: <TextSpan>[
                  TextSpan(
                      text: Constants.SIGNUP_BUTTON,
                      style: TextStyle(color: AppColors.green))
                ]))),
        placeHolderAboveButton: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
            },
            child: Text(Constants.LOGIN_FORGOT_PASSWORD,
                style: TextStyle(color: AppColors.text_grey))),
        fieldStyle: FieldStyle.value(0, 8, 24, const EdgeInsets.all(36),
            AppColors.underline, AppColors.green, AppColors.text_grey),
        field1Validator: (value) => FieldValidator.validateEmailAddress(value),
        field2Validator: (value) => FieldValidator.validatePassword(value),
        headerLayout: HomeAppBar(),
        fieldTypes: [FieldType.EMAIL, FieldType.PASSWORD],
        onValidation: (bool isValidationSuccess, String emailValue,
            String passwordValue) {
          if (!isValidationSuccess) {
            return;
          }
          _bloc.login(LoginData(loginId: emailValue, password: passwordValue));
        });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
