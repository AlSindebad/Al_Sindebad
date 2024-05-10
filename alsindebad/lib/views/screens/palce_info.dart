import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/appBar.dart';
import '../widgets/tabBar.dart';

class PlaceInfo extends StatefulWidget {
  @override
  _PlaceInfoState createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  List<String> imageUrls = [
    'https://madainproject.com/content/media/collect/hisham_palace_11726.jpg',
    'https://madainproject.com/content/media/collect/hisham_palace_22739.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Jerycho2.jpg/800px-Jerycho2.jpg',
  ];

  void _openGoogleMaps() async {
    String googleMapsUrl = 'https://maps.app.goo.gl/ir9NSbaLECUyRBcF8';

    if (await canLaunch(googleMapsUrl)) {
      // Launch the Google Maps app
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "The Hisham Palace"),
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.network(
                      imageUrls[index],
                      width: 400,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'The Hisham Palace',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Hisham's Palace is considered one of the most important tourist attractions in Palestine. The palace built by the Umayyad Caliph Hisham bin Abdul Malik was the headquarters of the state. The palace includes a group of buildings, bathtubs, mosques, and large halls filled with ancient columns. The mosaics on the bathroom floor, along with the Tree of Life in the guest room, are among the most important attractions for tourists and visitors, as the mosaics, decorations and ornaments are considered wonderful examples of ancient Islamic art and architecture. In addition to the six-pointed star, which was widely used in Islamic architecture throughout the ages, and the small museum that includes a collection of ceramic vessels discovered at the site."
                ,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 30), // Add a SizedBox with 16 pixels of height
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF112466), // Background color for the button
                  borderRadius: BorderRadius.circular(8.0), // Optional: for rounded corners
                ),
                child: IconButton(
                  onPressed: _openGoogleMaps,
                  icon: Icon(Icons.location_on ,size: 40,),
                  color: Colors.white,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
