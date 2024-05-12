import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import '../widgets/categories_view.dart';
import '../widgets/tabBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"Home Page"),
      body: Column(
        children: [
          Expanded(
            child: CategoriesComponent(),
          ),
          Expanded(
            child: NavigationExample(),
          ),
        ],
      ),
    );
  }
}
