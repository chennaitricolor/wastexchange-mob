import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/launch_setup.dart';
import 'package:wastexchange_mobile/resources/env_repository.dart';
import 'package:wastexchange_mobile/resources/auth_token_repository.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';

Future<void> main() async {
  await LaunchSetup([EnvRepository(), TokenRepository(), AppLogger()]).load();
  runApp(WasteExchange());
}

class WasteExchange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APP_TITLE,
      onGenerateRoute: Router.generateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(iconTheme: AppTheme.iconTheme),
        textTheme: AppTheme.textTheme,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationDelagates,
      localeResolutionCallback: (locale, supportedLocales) {
        return AppLocalizations.getCurrentLocale(locale);
      },
      home: MapScreen()
    );
  }
}
