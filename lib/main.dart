import 'package:flutter/material.dart';

void main() => runApp(WasteExchangeApp());

class WasteExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Exchange',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Waste Exchange'),
        ),
        body: Center(
          child: Text('Welcome'),
        ),
      ),
    );
  }
}