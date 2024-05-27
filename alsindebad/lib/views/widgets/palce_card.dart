
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final double averageRating;
  final Function()? onTap;

  const PlaceCard({
    Key? key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.averageRating,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFF112466);

    // حساب عدد النجوم المميزة بناءً على متوسط التقييم
    int numStarsToShow = averageRating.round(); // تقريب متوسط التقييم لأقرب رقم صحيح

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: myColor,
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            // Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < numStarsToShow; i++)
                              Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 4),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
