import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/screens/HomeScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  // Access the environment variables from the .env using DotEnv().env['MAPS_API_KEY'];
  
  runApp(HomeScreen());
}
