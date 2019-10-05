import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastexchange_mobile/app_localizations.dart';
import 'package:wastexchange_mobile/screens/splash_screen.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';

class AppHomeScreen extends StatelessWidget {

  static const routeName = '/appHomeScreen';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.APP_TITLE,
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: AppTheme.iconTheme, brightness: Brightness.light),
          textTheme: AppTheme.textTheme,
        ),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationDelagates,
        localeResolutionCallback: (locale, supportedLocales) {
          return AppLocalizations.getCurrentLocale(locale);
        },
        home: SplashScreen());
  }
}