import 'package:flutter/material.dart';

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
      leading: IconButton(
        icon: const Icon(Icons.menu), // Menu icon in leading
        onPressed: () {},
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
              onPressed: () {},
            ),
          ],
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
