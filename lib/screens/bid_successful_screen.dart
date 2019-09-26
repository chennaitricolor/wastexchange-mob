import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/my_bids_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_compact.dart';

class BidSuccessfulScreen extends StatelessWidget {
  static const String routeName = '/bidSuccessfulScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: AppColors.white),
            height: 90,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              ButtonViewCompact(text: 'View Bid', onPressed: () {
                Router.popToRootAndPushNamed(
                    context, MyBidsScreen.routeName);
              },),
              ButtonViewCompact(text: 'Home', onPressed: () {
                Router.popToRoot(context);
              },)
            ])),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/tick.png', width: 100, height: 100),
                const SizedBox(height: 16),
                const Text('You have placed the bid successfully!',
                    style: AppTheme.bodyThin),
              ]),
        ));
  }
}
