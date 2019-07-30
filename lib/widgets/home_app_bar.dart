import 'package:flutter/material.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({Key key})
      : super(
            key: key,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/ministry-logo.png',
                  height: 32,
                  fit: BoxFit.contain,
                ),
                Expanded(
                    child: Text('India Waste Exchange',
                        style: TextStyle(fontSize: 14, color: Colors.black))),
                Image.asset(
                  'assets/images/smart-city-logo.png',
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ],
            ));
}
