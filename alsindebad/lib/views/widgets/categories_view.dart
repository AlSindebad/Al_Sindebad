
import 'package:flutter/material.dart';

class CategoriesComponent extends StatelessWidget {
  const CategoriesComponent({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
