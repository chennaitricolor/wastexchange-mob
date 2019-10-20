import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/features/viewbids/presentation/screens/view_bids_screen.dart';
import 'package:wastexchange_mobile/core/utils/app_theme.dart';
import 'package:wastexchange_mobile/core/utils/constants.dart';
import 'package:wastexchange_mobile/core/widgets/bottom_action_view_container.dart';
import 'package:wastexchange_mobile/core/widgets/button_view_compact.dart';

class BidSuccessfulScreen extends StatelessWidget {
  static const String routeName = '/bidSuccessfulScreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: BottomActionViewContainer(children: <Widget>[
            Expanded(
                flex: 4,
                child: ButtonViewCompact(
                  text: Constants.BUTTON_VIEW_ALL_BIDS,
                  onPressed: () {
                    Router.popToRootAndPushNamed(
                        context, ViewBidsScreen.routeName);
                  },
                )),
            Spacer(),
            Expanded(
                flex: 4,
                child: ButtonViewCompact(
                    text: Constants.BUTTON_HOME,
                    onPressed: () {
                      Router.popToRoot(context);
                    }))
          ]),
          body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/tick.png',
                        width: 100, height: 100),
                    const Text('You have successfully placed the bid!',
                        textAlign: TextAlign.center, style: AppTheme.bodyThin),
                  ])),
        ));
  }
}
