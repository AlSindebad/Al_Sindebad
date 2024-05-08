import 'package:flutter/material.dart';

void main() => runApp(const OutlinedButtonExampleApp());

class OutlinedButtonExampleApp extends StatelessWidget {
  const OutlinedButtonExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('OutlinedButton Sample')),
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
          Size(200, 50), // تحديد حجم الزر الكبير
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF112466)),
        // تعيين لون النص
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        // تعيين حدود للزر
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.black), // لون الحدود
          ),
        ),
      ),
      child: const Text('Sign up'),
    );
  }
}
