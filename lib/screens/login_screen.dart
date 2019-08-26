import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/login_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/screens/seller-information-screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/widget_display_util.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this._sellerInformation);

  static const routeName = '/loginScreen';

  final SellerInformation _sellerInformation;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;
  final FieldType _email = FieldType.value(
      Constants.FIELD_EMAIL, 50, TextInputType.emailAddress, false);
  final FieldType _password =
      FieldType.value(Constants.FIELD_PASSWORD, 15, TextInputType.text, true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //TODO(Sayeed): Why do we need this method
  SellerInformation _sellerInformation() => widget._sellerInformation;
  bool isSellerInfoAvailable() => _sellerInformation() != null;

  void _routeToNextScreen() {
    if (isSellerInfoAvailable()) {
      _routeToSellerInfo();
    } else {
      _routeToMapScreen();
    }
  }

  void _routeToSellerInfo() {
    Router.pushReplacementNamed(context, SellerInformationScreen.routeName,
        arguments: _sellerInformation());
  }

  void _routeToMapScreen() {
    Router.removeAllAndPush(context, MapScreen.routeName);
  }

  void _routeToRegistrationScreen() {
    Router.pushNamed(context, RegistrationScreen.routeName);
  }

  @override
  void initState() {
    _bloc = LoginBloc();
    _bloc.loginStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          DisplayUtil.instance.showLoadingDialog(context);
          break;
        case Status.ERROR:
          DisplayUtil.instance.dismissDialog(context);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: const Text(Constants.LOGIN_FAILED)));
          break;
        case Status.COMPLETED:
          if (_snapshot.data.success) {
            DisplayUtil.instance.dismissDialog(context);
            _routeToNextScreen();
          }
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: AuthenticationView(
            placeHolderBelowButton: MaterialButton(
                onPressed: () {
                  _routeToRegistrationScreen();
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
            fieldStyle: FieldStyle.value(16, 8, 24, 36, AppColors.underline,
                AppColors.green, AppColors.text_grey),
            fieldValidator: (hintAsKey, values) {
              final String value = values[hintAsKey];
              switch (hintAsKey) {
                case Constants.FIELD_EMAIL:
                  return FieldValidator.validateEmailAddress(value);
                case Constants.FIELD_PASSWORD:
                  return FieldValidator.validatePassword(value);
                default:
                  return null;
              }
            },
            headerLayout: HomeAppBar(),
            fieldTypes: [_email, _password],
            onValidation: (isValidationSuccess, valueMap) {
              if (!isValidationSuccess) {
                return;
              }
              final email = valueMap[Constants.FIELD_EMAIL];
              final password = valueMap[Constants.FIELD_PASSWORD];
              final LoginData data =
                  LoginData(loginId: email, password: password);
              _bloc.login(data);
            }));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
