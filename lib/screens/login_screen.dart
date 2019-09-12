import 'package:authentication_view/authentication_view.dart';
import 'package:authentication_view/field_style.dart';
import 'package:authentication_view/field_type.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/blocs/login_bloc.dart';
import 'package:wastexchange_mobile/models/login_data.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/seller_bid_data.dart';
import 'package:wastexchange_mobile/models/seller_info.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/screens/seller_bid_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/utils/field_validator.dart';
import 'package:wastexchange_mobile/utils/locale_constants.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:wastexchange_mobile/utils/widget_display_util.dart';

import '../app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this._sellerInfo);

  static const routeName = '/loginScreen';

  final SellerInfo _sellerInfo;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // TODO(Sayeed): Why do we need this method
  bool isSellerInfoAvailable() => widget._sellerInfo != null;

  void _routeToNextScreen() {
    if (isSellerInfoAvailable()) {
      _routeToSellerInfo();
    } else {
      _routeToMapScreen();
    }
  }

  void _routeToSellerInfo() {
    Router.pushReplacementNamed(context, SellerBidScreen.routeNameForSellerItem,
        arguments: SellerBidData(sellerInfo: widget._sellerInfo));
  }

  void _routeToMapScreen() {
    Router.popToRoot(context);
  }

  void _routeToRegistrationScreen() {
    Router.pushNamed(context, RegistrationScreen.routeName);
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    _bloc = LoginBloc();
    _bloc.loginStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          showLoadingDialog(context);
          break;
        case Status.ERROR:
          dismissDialog(context);
          _showSnackBar(AppLocalizations.of(context).translate(LocaleConstants.LOGIN_FAILED));
          break;
        case Status.COMPLETED:
          dismissDialog(context);
          if (!_snapshot.data.approved) {
            _showSnackBar(Constants.LOGIN_UNAPPROVED);
            return;
          }
          if (!_snapshot.data.success) {
            _showSnackBar(AppLocalizations.of(context).translate(LocaleConstants.LOGIN_FAILED));
            return;
          }
          _routeToNextScreen();
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FieldType _email = FieldType.value(
      AppLocalizations.of(context).translate(LocaleConstants.EMAIL_FIELD), 50, TextInputType.emailAddress, false);
    final FieldType _password = FieldType.value(
        AppLocalizations.of(context).translate(LocaleConstants.PASSWORD_FIELD), 15, TextInputType.text, true);
    return Scaffold(
        key: _scaffoldKey,
        body: AuthenticationView(
            placeHolderBelowButton: MaterialButton(
                onPressed: () {
                  _routeToRegistrationScreen();
                },
                child: RichText(
                    text: TextSpan(
                        text: AppLocalizations.of(context).translate(LocaleConstants.LOGIN_NOT_MEMBER),
                        style: AppTheme.subtitle,
                        children: <TextSpan>[
                      TextSpan(
                          text: AppLocalizations.of(context).translate(LocaleConstants.SIGNUP_BUTTON),
                          style: AppTheme.subtitleGreen)
                    ]))),
            fieldStyle: FieldStyle.value(16, 8, 24, 36, AppColors.underline,
                AppColors.green, AppColors.text_grey),
            fieldValidator: (hintAsKey, values) {
              final String value = values[hintAsKey];
              switch (hintAsKey) {
                case LocaleConstants.EMAIL_FIELD:
                  return FieldValidator.validateEmailAddress(value);
                case LocaleConstants.PASSWORD_FIELD:
                  return FieldValidator.validatePassword(value);
                default:
                  return null;
              }
            },
            headerLayout: HomeAppBar(onBackPressed: () {
              Navigator.pop(context, false);
            }),
            fieldTypes: [_email, _password],
            buttonText: AppLocalizations.of(context).translate(LocaleConstants.CONTINUE),
            onValidation: (isValidationSuccess, valueMap) {
              if (!isValidationSuccess) {
                return;
              }
              print("debugging");
              print(valueMap);
              print(AppLocalizations.of(context).translate(LocaleConstants.EMAIL_FIELD));
              print(AppLocalizations.of(context).translate(LocaleConstants.PASSWORD_FIELD));
              final email = valueMap[AppLocalizations.of(context).translate(LocaleConstants.EMAIL_FIELD)];
              print(email);
              final password = valueMap[AppLocalizations.of(context).translate(LocaleConstants.PASSWORD_FIELD)];
              print(password);
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
