import 'package:flutter/material.dart';

void main() => runApp(const LButton());

class LButton extends StatelessWidget {
  const LButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('')),
        body: const Center(
          child: OutlinedButtonExample(),
        ),
      ),
    );
  }
}

class OutlinedButtonExample extends StatelessWidget {
  const OutlinedButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        debugPrint('Received click');
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(240, 70),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF112466)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
      child: const Text(''),
    );
  }
}
