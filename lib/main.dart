import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/launch_setup.dart';
import 'package:wastexchange_mobile/resources/env_repository.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

Future<void> main() async {
  await LaunchSetup([EnvRepository(), TokenRepository(), AppLogger()]).load();
  runApp(WasteExchange());
}

class WasteExchange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MapScreen(),
        title: Constants.APP_TITLE,
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 72.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
            title: TextStyle(
                fontSize: 36.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600),
            body1: TextStyle(
                fontSize: 14.0,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}
