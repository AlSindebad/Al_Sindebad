import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';

class CustomAppBarNavigateBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBarNavigateBack({Key? key, required this.title, this.onBackPressed}) : super(key: key);

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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Back arrow icon in leading
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      actions: [
        Row(
          children: <Widget>[
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
