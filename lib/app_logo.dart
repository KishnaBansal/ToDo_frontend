import 'package:flutter/material.dart';

class CommonLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          "https://pluspng.com/img-png/avengers-logo-png-avengers-logo-png-1376.png",
          width: 100,
        ),
        Text(
          "To-Do App",
          style: TextStyle(
            fontSize: 22, // Equivalent to `xl2`
            fontStyle: FontStyle.italic, // Adds italics
          ),
        ),
        Text(
          "Make A List of your task",
          style: TextStyle(
            fontSize: 18, // Equivalent to `lg`
            color: Colors.white, // Matches `.white`
            fontWeight: FontWeight.w300, // Equivalent to `.light`
            letterSpacing: 1.0, // Equivalent to `.wider`
          ),
        ),
      ],
    );
  }
}