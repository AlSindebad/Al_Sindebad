import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF112466), // تعديل اللون حسب الحاجة
      ),
    );
  }
}
