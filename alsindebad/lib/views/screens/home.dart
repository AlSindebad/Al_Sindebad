import 'package:alsindebad/data/models/place.dart';
import 'package:alsindebad/views/screens/palce_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/place_service.data.dart';
import '../widgets/appBar.dart';
import '../widgets/categories_view.dart';
import '../widgets/palce_card.dart';
import '../widgets/search_component.dart';
import '../widgets/tabBar.dart';
import '../widgets/signin.dart';

class Home extends StatelessWidget {

  final PlacesService placesService = PlacesService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home Page"),
      body: Column(
        children: [
          Expanded(child: SearchBarView()),
          SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: CategoriesComponent(),
          ),
          Expanded(
            flex: 9,
            child: FutureBuilder(
              future: placesService.getPlaces(),
              builder: (context, AsyncSnapshot<List<Places>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Places> places = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      Places place = places[index];
                      return PlaceCard(
                        title: place.placeName,
                        location: place.placelocation,
                        imageUrl: place.placeImage,
                        numStars: place.placeReview,
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceInfo(
                                id: place.placeId,
                                googleMapsUrl: place.locationUrl,
                              ),
                            ),
                          );                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Expanded(child: NavigationExample()),
        ],
      ),
    );
  }
}
