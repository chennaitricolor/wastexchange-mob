import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/buyer_bid_confirmation_screen_launch_data.dart';
import 'package:wastexchange_mobile/screens/bid_successful_screen.dart';
import 'package:wastexchange_mobile/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/screens/forgot_password_screen.dart';
import 'package:wastexchange_mobile/screens/login_screen.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/my_bids_screen.dart';
import 'package:wastexchange_mobile/screens/otp_screen.dart';
import 'package:wastexchange_mobile/screens/registration_screen.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';

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

      case SellerItemScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SellerItemScreen(sellerInfo: settings.arguments));

      case BuyerBidConfirmationScreen.routeName:
        final BuyerBidConfirmationScreenLaunchData data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BuyerBidConfirmationScreen(
                  seller: data.seller,
                  bidItems: data.bidItems,
                  restoreSavedState: data.restoreSavedState,
                  onBackPressed: data.onBackPressed,
                ));

      case MyBidsScreen.routeName:
        return MaterialPageRoute(builder: (_) => MyBidsScreen());

      case BidSuccessfulScreen.routeName:
        return MaterialPageRoute(builder: (_) => BidSuccessfulScreen());

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

  static void popToRootAndPushNamed(BuildContext context, String routeName) {
    popToRoot(context);
    pushNamed(context, routeName);
  }

  static void popAndPushNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.popAndPushNamed(context, routeName, arguments: arguments);
  }

  static void removeAllAndPush(BuildContext context, String routeName,
      {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }

  static void removeAllAndPopToHome(BuildContext context, {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        context, Navigator.defaultRouteName, (Route<dynamic> route) => false);
  }

  static void popToRoot(BuildContext context, {dynamic arguments}) {
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}
