import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/place_Category_viewmodel.dart';

class CategoriesComponent extends StatelessWidget {
  CategoriesComponent({Key? key}) : super(key: key);

  final List<Map<String, String>> categories = [
    {'image': 'assets/images/mosque.png', 'name': 'Mosque'},
    {'image': 'assets/images/church.png', 'name': 'Church'},
    {'image': 'assets/images/park.png', 'name': 'Park'},
    {'image': 'assets/images/ocean.png', 'name': 'Ocean'},
    {'image': 'assets/images/mountain.png', 'name': 'Mountain'},
    {'image': 'assets/images/archaeology.png', 'name': 'Archaeology'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var category = categories[index];
            return GestureDetector(
              onTap: () {
                Provider.of<PlaceCategory>(context, listen: false).setSelectedCategory(category['name']!);
              },
              child: Image.asset(
                category['image']!,
                fit: BoxFit.cover,
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 9,
          ),
          itemCount: categories.length,
        ),
      ),
    );
  }
}
