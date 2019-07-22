import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/HomeAppBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Exchange',
      home: Scaffold(
        appBar: HomeAppBar(),
        body: Center(
          child: Text('Login'),
        ),
      ),
    );
  }
}