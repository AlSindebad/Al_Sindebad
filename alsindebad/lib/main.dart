import 'package:flutter/material.dart';
//import 'views/categories_view.dart';
import 'views/search_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      //home: CategoriesComponent(),
     // home:SearchBarView (),
    );
  }
}
