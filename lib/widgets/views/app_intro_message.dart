import 'package:flutter/material.dart';

class AppIntroMessage extends StatelessWidget {
  const AppIntroMessage(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
