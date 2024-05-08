import 'package:flutter/material.dart';
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
    final Color iconColor = Color(0xFF112466); // تعريف اللون المطلوب

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
              setState(() {
                currentPageIndex = 0;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            iconSize: 30,
            color: iconColor, // تعيين اللون المطلوب
            onPressed: () {
              setState(() {
                currentPageIndex = 1;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            iconSize: 30,
            color: iconColor, // تعيين اللون المطلوب
            onPressed: () {
              setState(() {
                currentPageIndex = 2;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            iconSize: 30,
            color: iconColor, // تعيين اللون المطلوب
            onPressed: () {
              setState(() {
                currentPageIndex = 3;
              });
            },
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.headline6,
              ),
            ),
          ),
        ),

        /// Contact page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Contact page',
                style: theme.textTheme.headline6,
              ),
            ),
          ),
        ),

        /// Location page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Location page',
                style: theme.textTheme.headline6,
              ),
            ),
          ),
        ),

        /// QR Code page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'QR Code page',
                style: theme.textTheme.headline6,
              ),
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}

