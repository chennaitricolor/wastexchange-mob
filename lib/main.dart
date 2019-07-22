import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/screens/waste_exchange_map_screen.dart';

void main() => runApp(WasteExchangeApp());

class WasteExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Waste Exchange",
      home: WasteExchangeMapScreen(),
    );
  }
}