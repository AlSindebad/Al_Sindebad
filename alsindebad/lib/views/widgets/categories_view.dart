import 'package:flutter/material.dart';

class CategoriesComponent extends StatelessWidget {
  CategoriesComponent({Key? key}) : super(key: key);

  // List of category images
  final List<String> categoryImages = [
    'assets/images/mosque.png',
    'assets/images/church.png',
    'assets/images/park.png',
    'assets/images/ocean.png',
    'assets/images/mountain.png',
    'assets/images/archaeology.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // Create an image for each category
                return GestureDetector(
                  onTap: () {
                  },
                  child: Image.asset(
                    categoryImages[index],

                    fit: BoxFit.cover,

                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 9,
              ),
              itemCount: categoryImages.length,
            ),
          ),
        ),
      ),
    );
  }
}
