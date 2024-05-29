import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Color(0xFF112466)),
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: Color(0xFF112466)),
        ),
      ),

      actions: [
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications), // Notifications icon in actions
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.account_circle), // Account circle icon in actions
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
