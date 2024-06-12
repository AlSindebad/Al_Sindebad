import 'package:flutter/material.dart';

enum ImageShape {
  rounded
}

class EventCard extends StatelessWidget {
  final String eventName;
  final String imageUrl;
  final ImageShape imageShape;

  const EventCard({
    Key? key,
    required this.eventName,
    required this.imageUrl,
    this.imageShape = ImageShape.rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = const Color(0xFF112466);

    BoxDecoration getDecoration() {
      switch (imageShape) {
        case ImageShape.rounded:
          return BoxDecoration(
            borderRadius: BorderRadius.circular(31),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
            ),
          );
      }}
    return Card(
      color: cardColor,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 70,
              decoration: getDecoration(),
            ),

            SizedBox(width: 27),
            Expanded(
              child: Text(
                eventName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
