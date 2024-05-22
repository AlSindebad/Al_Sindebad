import 'package:flutter/material.dart';


class SButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String buttonText;

  const SButton({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Center(
          child: OutlinedButtonExample(
            backgroundColor: backgroundColor,
            textColor: textColor,
            buttonText: buttonText,
          ),
        ),
      ),
    );
  }
}

class OutlinedButtonExample extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String buttonText;

  const OutlinedButtonExample({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        debugPrint('Received click');
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(100, 50),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
