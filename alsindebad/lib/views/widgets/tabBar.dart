import 'package:alsindebad/views/screens/emergancy_call.dart';
import 'package:alsindebad/views/screens/home.dart';
import '../screens/map.dart';

import 'package:flutter/material.dart';

import '../screens/qr_scanner.dart';
class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color iconColor = Color(0xFF112466);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          IconButton(
            icon: Icon(Icons.home_outlined),
            iconSize: 30,
            color: iconColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );

            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            iconSize: 30,
            color: iconColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyCall()),
              );

            },
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            iconSize: 30,
            color: iconColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Map()),
              );

            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            iconSize: 30,
            color: iconColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRScanner()),
              );
            },
          ),
        ],
      ),

    );
  }
}
