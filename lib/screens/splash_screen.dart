import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastexchange_mobile/routes/router.dart';
import 'package:wastexchange_mobile/screens/map_screen.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';
import 'package:wastexchange_mobile/widgets/views/thought_works_logo.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  void navigationToNextPage() {
    Router.pushNamed(context, MapScreen.routeName);
  }

  startSplashScreenTimer() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(children: <Widget>[
          Expanded(child: Container(color: AppColors.chrome_grey, child: Image.asset('assets/images/smart-cities-mission-logo.png'),)),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: ThoughtWorksLogo(),
          )
        ],));
  }
}
