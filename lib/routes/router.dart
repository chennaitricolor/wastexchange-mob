import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/features/buyerbids/presentation/screens/bid_successful_screen.dart';
import 'package:wastexchange_mobile/features/viewbids/presentation/screens/bid_detail_screen.dart';
import 'package:wastexchange_mobile/features/buyerbids/presentation/screens/buyer_bid_confirmation_screen.dart';
import 'package:wastexchange_mobile/features/forgotpassword/presentation/screens/forgot_password_screen.dart';
import 'package:wastexchange_mobile/features/login/presentation/screens/login_screen.dart';
import 'package:wastexchange_mobile/features/home/presentation/screens/map_screen.dart';
import 'package:wastexchange_mobile/features/viewbids/presentation/screens/view_bids_screen.dart';
import 'package:wastexchange_mobile/features/otp/presentation/screens/otp_screen.dart';
import 'package:wastexchange_mobile/features/registration/presentation/screens/registration_screen.dart';
import 'package:wastexchange_mobile/features/selleritems/presentation/screens/seller_item_screen.dart';

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
        return MaterialPageRoute(
            builder: (_) =>
                BuyerBidConfirmationScreen(data: settings.arguments));

      case ViewBidsScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewBidsScreen());

      case BidSuccessfulScreen.routeName:
        return MaterialPageRoute(builder: (_) => BidSuccessfulScreen());

      case BidDetailScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BidDetailScreen(bid: settings.arguments));

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

  static void popToRootAndPushNamed(BuildContext context, String routeName,
      {dynamic arguments}) {
    popToRoot(context);
    pushNamed(context, routeName, arguments: arguments);
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
