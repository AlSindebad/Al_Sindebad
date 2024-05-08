import 'package:flutter/material.dart';
import 'views/widgets/navbar.dart';
import 'views/widgets/appBar.dart';
import 'views/widgets/cardNotification.dart';
import 'views/widgets/meduimButton.dart';
import 'views/widgets/smallButton.dart';
import 'views/widgets/largButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,


home:NavigationExample(),
    );
  }
}
