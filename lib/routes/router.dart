import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/screens/forgot_password_screen.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/screens/seller_information_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MapScreen.routeName:
        return MaterialPageRoute(builder: (_) => MapScreen());

      case LoginScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(settings.arguments));

      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());

      case OTPScreen.routeName:
        return MaterialPageRoute(builder: (_) => OTPScreen(settings.arguments));

      case RegistrationScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());

      case SellerInformationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                SellerInformationScreen(sellerInfo: settings.arguments));

      case BuyerBidConfirmationScreen.routeName:
        final Map<String, dynamic> argsMap = settings.arguments;
        final seller = argsMap['seller'];
        final bidItems = argsMap['bidItems'];
        return MaterialPageRoute(
            builder: (_) =>
                BuyerBidConfirmationScreen(seller: seller, bidItems: bidItems));
      default:
        return null;
    }
  }

  static void pushReplacementNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void pushNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void removeAllAndPush(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }
}
