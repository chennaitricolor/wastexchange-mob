import 'package:flutter/material.dart';

class LoginToBuyButton extends StatelessWidget {
  const LoginToBuyButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton(
        color: Colors.white,
        child: const Text(
          'Login to buy',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 25.0,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}