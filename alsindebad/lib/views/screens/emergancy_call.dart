import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import '../widgets/tabBar.dart';

class EmergancyCall extends StatelessWidget {
  const EmergancyCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Emergency Calls'),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      print('Police car icon tapped');
                    },
                    child: Container(
                      height: 90,
                      child: Image.asset('assets/images/police-car.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Phone call icon tapped');
                    },
                    child: Container(
                      height: 90,
                      child: Image.asset('assets/images/phone-call.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Call icon tapped');
                    },
                    child: Container(
                      height: 100,
                      child: Image.asset('assets/images/call.png'),
                    ),
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
