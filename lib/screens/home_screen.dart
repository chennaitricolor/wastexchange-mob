import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/models/seller_information.dart';
// import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/seller-information-screen.dart';
import 'package:wastexchange_mobile/util/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SellerInformation sellerInformation;
    return MaterialApp(
      title: Constants.APP_TITLE,
      home: SellerInformationScreen(sellerInfo: sellerInformation),
    );
  }
}
