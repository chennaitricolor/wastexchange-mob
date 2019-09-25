import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/screens/my_bids_screen.dart';
import 'package:wastexchange_mobile/screens/seller_item_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';

class BidSuccessfulScreen extends StatelessWidget {
  static const String routeName = '/bidSuccessfulScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: AppColors.chrome_grey),
            height: 70,
            child: Row(children: <Widget>[
              Expanded(
                  child: SizedBox(
                      height: 44,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(26, 0, 13, 0),
                          child: RaisedButton(
                              color: AppColors.green,
                              child: const Text(
                                'View Bid',
                                style: AppTheme.buttonTitle,
                              ),
                              onPressed: () {
                                Router.popToRootAndPushNamed(
                                    context, MyBidsScreen.routeName);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0))))),
                  flex: 2),
              Expanded(
                  child: SizedBox(
                      height: 44,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 26, 0),
                          child: RaisedButton(
                              color: AppColors.green,
                              child: const Text(
                                'Home',
                                style: AppTheme.buttonTitle,
                              ),
                              onPressed: () {
                                Router.popToRoot(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0))))),
                  flex: 2)
            ])),
        body: Container(
            decoration: BoxDecoration(color: AppColors.chrome_grey),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/images/tick.png')),
                    const Text('You have placed the bid successfully!',
                        style: AppTheme.bodyThin),
                    const SizedBox(height: 25),
                  ]),
            )));
  }
}
