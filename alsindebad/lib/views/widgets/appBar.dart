import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alsindebad/views/screens/profile_screen.dart';

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
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // الانتقال إلى صفحة البروفايل عند الضغط على زر الحساب
                Navigator.pushNamed(context, '/ProfileScreen');
              },
            ),
          ],
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
