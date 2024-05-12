import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import '../widgets/tabBar.dart';

class emergency_calls extends StatelessWidget {
  const emergency_calls({Key? key}) : super(key: key);

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Emergency Calls'),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 90,
                    child: Image.asset('lib/views/icons/police-car.png'),
                  ),
                  Container(
                    height: 90,
                    child: Image.asset('lib/views/icons/phone-call.png'),
                  ),
                  Container(
                    height: 100,
                    child: Image.asset('lib/views/icons/call.png'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60, // Adjust the height as needed
            child: NavigationExample(),
          ),
        ],
      ),
    );
  }
}


















