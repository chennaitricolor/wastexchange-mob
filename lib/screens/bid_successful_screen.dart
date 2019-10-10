import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/my_bids_screen.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/widgets/views/bottom_action_view_container.dart';
import 'package:wastexchange_mobile/widgets/views/button_view_compact.dart';

class BidSuccessfulScreen extends StatelessWidget {
  static const String routeName = '/bidSuccessfulScreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            bottomNavigationBar: BottomActionViewContainer(children: <Widget>[
              ButtonViewCompact(
                text: 'View All Bids',
                onPressed: () {
                  Router.popToRootAndPushNamed(context, MyBidsScreen.routeName);
                },
              ),
              const SizedBox(width: 24),
              ButtonViewCompact(
                  text: 'Home',
                  onPressed: () {
                    Router.popToRoot(context);
                  })
            ]),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/tick.png',
                        width: 100, height: 100),
                    const SizedBox(height: 16),
                    const Text('You have placed the bid successfully!', textAlign: TextAlign.center,
                        style: AppTheme.bodyThin),
                  ]),
            )));
  }
}
