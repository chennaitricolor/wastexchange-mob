import 'package:flutter/material.dart';

class HomeAppBar extends AppBar {
  final _formKey = new GlobalKey<FormState>();
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
                  fit: BoxFit.contain,
                  height: 32,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('India Waste Exchange', style: TextStyle(color: Colors.black))),
                Image.asset(
                  'assets/images/smart-city-logo.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),

              ],
            ));
}
