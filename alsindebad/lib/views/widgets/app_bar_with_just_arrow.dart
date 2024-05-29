import 'package:flutter/material.dart';
import 'package:alsindebad/views/screens/profile_screen.dart';
class CustomAppBarNavigateJustBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBarNavigateJustBack({Key? key, required this.title, this.onBackPressed}) : super(key: key);

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
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
