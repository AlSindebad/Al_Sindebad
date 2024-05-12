import 'package:flutter/material.dart';

import '../widgets/appBar.dart';
import '../widgets/tabBar.dart';

class EmergancyCall extends StatefulWidget {
  const EmergancyCall({Key? key}) : super(key: key);

  @override
  State<EmergancyCall> createState() => _EmergancyCallState();
}

class _EmergancyCallState extends State<EmergancyCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"Emergancy Call"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                // Implement your emergency call functionality here
                // For example, you can use the url_launcher package to launch a phone call
              },
              child: Text('Call 911'),
            ),
        Expanded(
          child: NavigationExample(),)
          ],
        ),
      ),
    );
  }
}
